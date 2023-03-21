//
//  SearchViewController.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import UIKit
import RxSwift
import RxCocoa

class SearchMainViewController: BaseViewController {
    private var disposeBag = DisposeBag()
    private let viewModel = SearchMainViewModel()
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "게임, 앱, 스토리 등"
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.autocorrectionType = .no
        controller.edgesForExtendedLayout = .all
        controller.obscuresBackgroundDuringPresentation = false
        
        return controller
    }()
    
    // MARK: - 최근검색어
    private let recentTitleView = RecentHeaderView()
    
    private let recentSearchTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.register(
            RecentTermTableViewCell.self,
            forCellReuseIdentifier: RecentTermTableViewCell.identifier
        )
        tableView.rowHeight = 44
        return tableView
    }()
    
    // MARK: - 검색결과
    private let searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(
            SearchListTableViewCell.self,
            forCellReuseIdentifier: SearchListTableViewCell.identifier
        )
        tableView.backgroundColor = .white
        tableView.rowHeight = UITableView.automaticDimension
        tableView.isHidden = true
        tableView.separatorStyle = .none
        return tableView
    }()
    
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        
        let views = [
            recentTitleView,
            recentSearchTableView,
            searchResultTableView
        ]
        
        view.addSubviews(views)
    }
    
    override func initConstraints() {
        super.initConstraints()
        
        recentTitleView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(16)
            make.horizontalEdges.equalToSuperview().inset(18)
            make.height.equalTo(44)
        }
        
        recentSearchTableView.snp.makeConstraints { make in
            make.top.equalTo(recentTitleView.snp.bottom)
            make.leading.trailing.bottom.equalToSuperview()
        }
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.horizontalEdges.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    override func bindUI() {
        super.bindUI()
        
        viewModel.outputs.searchListObservable
            .bind(to: searchResultTableView.rx.items(
                cellIdentifier: SearchListTableViewCell.identifier,
                cellType: SearchListTableViewCell.self)
            ) { index, item, cell in
                cell.searchSnippet = item
            }.disposed(by: disposeBag)
    }
    
    override func subscribeUI() {
        super.subscribeUI()
        
        searchController.searchBar.rx.searchButtonClicked
            .bind(with: self) { owner, _ in
                let searchBar = owner.searchController.searchBar
                guard let term = searchBar.text else { return }
                owner.search(term: term)
            }.disposed(by: disposeBag)
        
        searchResultTableView.rx.modelSelected(SearchResult.self)
            .bind(with: self) { owner, model in
                print(model.trackName)
            }.disposed(by: disposeBag)
        
        searchResultTableView.rx.willDisplayCell
            .bind(with: self) { owner, cell in
                let term = owner.searchController.searchBar.text ?? ""
                owner.viewModel.inputs.fetchMoreList(
                    term: term,
                    row: cell.indexPath.row
                )
            }.disposed(by: disposeBag)
    }
}

// MARK: - SearchData Bind Method
extension SearchMainViewController {
    private func search(term: String) {
        viewModel.inputs.search(term: term)
        searchResultTableView.isHidden = false
        recentSearchTableView.isHidden = true
        recentTitleView.isHidden = true
        
    }
}

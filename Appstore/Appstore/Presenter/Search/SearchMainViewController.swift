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
    
    private let searchController: UISearchController = {
        let controller = UISearchController()
        controller.searchBar.placeholder = "게임, 앱, 스토리 등"
        controller.searchBar.autocapitalizationType = .none
        controller.searchBar.autocorrectionType = .no
        
        return controller
    }()
    
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
    
    override func setupViews() {
        super.setupViews()
        
        view.backgroundColor = .white
        navigationItem.searchController = searchController
        
        view.addSubview(recentTitleView)
        view.addSubview(recentSearchTableView)
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
    }
}

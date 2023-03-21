//
//  SearchMainViewModel.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/20.
//

import Foundation
import RxSwift
import RxRelay

protocol SearchMainViewModelInput {
    func search(term: String)
    func fetchMoreList(term: String, row: Int)
    
    var searchListRelay: PublishRelay<[SearchResult]> { get }
    var recentWordRelay: PublishRelay<[String]> { get }
    var autoCompleteRelay: PublishRelay<[String]> { get }
    var errorRelay: PublishRelay<Void> { get }
    var emptyRelay: PublishRelay<Void> { get }
}

protocol SearchMainViewModelOutput {
    var searchListObservable: Observable<[SearchResult]> { get }
    var recentWordObservable: Observable<[String]> { get }
    var autoCompleteObservable: Observable<[String]> { get }
    var errorObservable: Observable<Void> { get }
    var emptyObservable: Observable<Void> { get }
}

class SearchMainViewModel: SearchMainViewModelInput,
                           SearchMainViewModelOutput {
    
    private var disposeBag = DisposeBag()
    
    var inputs: SearchMainViewModelInput { return self }
    var outputs: SearchMainViewModelOutput { return self }
    
    var searchListRelay = PublishRelay<[SearchResult]>()
    var searchListObservable: Observable<[SearchResult]> {
        return searchListRelay.asObservable()
    }
    
    var recentWordRelay = PublishRelay<[String]>()
    var recentWordObservable: Observable<[String]> {
        return recentWordRelay.asObservable()
    }
    
    var autoCompleteRelay = PublishRelay<[String]>()
    var autoCompleteObservable: Observable<[String]> {
        return autoCompleteRelay.asObservable()
    }
    
    var errorRelay = PublishRelay<Void>()
    var errorObservable: Observable<Void> {
        return errorRelay.asObservable()
    }
    
    var emptyRelay = PublishRelay<Void>()
    var emptyObservable: Observable<Void> {
        return emptyRelay.asObservable()
    }
    
    private var searchResultList = [SearchResult]()
    
    private var offset = 20
    private let limit = 20
    private var isMoreItems = true
    private var isRequesting = false
    private var term = String()
    
    func search(term: String) {
        // 중복 호출 방지
        guard !isRequesting, isMoreItems else { return }
        isRequesting = true
        
        self.term = term
        
        let params = SearchParameter(term: term, offset: offset, limit: limit)
        SearchService.fetch(params: params)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self, onSuccess: { owner, result in
                if result.resultCount < owner.limit {
                    owner.isMoreItems = false
                } else {
                    owner.offset += owner.limit
                    owner.isMoreItems = true
                }
                
                if result.results.count == 0 {
                    owner.emptyRelay.accept(())
                } else {
                    owner.searchResultList.append(contentsOf: result.results)
                    owner.searchListRelay.accept(owner.searchResultList)
                }
                // TODO: - 최근 검색어 저장
                owner.isRequesting = false
            }, onFailure: { owner, error in
                owner.errorRelay.accept(())
            }).disposed(by: disposeBag)
    }
    
    func fetchMoreList(term: String, row: Int) {
        if searchResultList.count - 3 <= row {
            search(term: term)
        }
    }
}

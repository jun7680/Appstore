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
    
    var searchList: PublishRelay<[SearchResult]> { get }
}

protocol SearchMainViewModelOutput {
    var searchListObservable: Observable<[SearchResult]> { get }
}

class SearchMainViewModel: SearchMainViewModelInput,
                           SearchMainViewModelOutput {
    
    private var disposeBag = DisposeBag()
    
    var inputs: SearchMainViewModelInput { return self }
    var outputs: SearchMainViewModelOutput { return self }
    
    var searchList = PublishRelay<[SearchResult]>()
    var searchListObservable: Observable<[SearchResult]> {
        return searchList.asObservable()
    }
    
    private var offset = 20
    private let limit = 20
    
    func search(term: String) {
        let params = SearchParameter(term: term, offset: offset, limit: limit)
        SearchService.fetch(params: params)
            .subscribe(on: ConcurrentDispatchQueueScheduler(qos: .background))
            .observe(on: MainScheduler.asyncInstance)
            .subscribe(with: self) { owner, items in
                owner.searchList.accept(items.results)
            }.disposed(by: disposeBag)
    }
}

//
//  SearchService.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import Foundation
import RxSwift

protocol SearchServiceType {
    static func fetch(params: SearchParameter) -> Single<SearchResultResponse>
}

class SearchService: SearchServiceType {
    static func fetch(params: SearchParameter) -> Single<SearchResultResponse> {
        let type = SearchAPI.fetch(params: params)
        return SessionManager.request(type: type)
    }
}

//
//  SearchAPI.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import Foundation

enum SearchAPI {
    case fetch(params: SearchParameter)
}

extension SearchAPI: APIType {
    var baseURL: URL {
        guard let url = URL(string: "http://itunes.apple.com/")
        else { fatalError("BaseURL is Wrong...") }
        
        return url
    }
    
    var path: String {
        switch self {
        case .fetch: return "search"
        }
    }
    
    var params: [String : Any] {
        switch self {
        case let .fetch(params):
            return [
                "term": params.term,
                "limit": params.limit,
                "offset": params.offset,
                "entity": "software",
                "country": "KR"
            ]
        }
    }
}

//
//  APIType.swift
//  Appstore
//
//  Created by 옥인준 on 2023/03/19.
//

import Foundation

protocol APIType {
    var baseURL: URL { get }
    var path: String { get }
    var params: [String: Any] { get }
}

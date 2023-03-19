//
//  SearchService.swift
//  AppstoreTests
//
//  Created by 옥인준 on 2023/03/19.
//

import XCTest
import RxBlocking

@testable import Appstore

final class SearchServiceTest: XCTestCase {
    
    override func setUpWithError() throws {
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func fetchTest() throws {
        let params = SearchParameter(
            term: "카카오",
            offset: 0,
            limit: 30
        )
        let dto = try SearchService.fetch(params: params)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto)
        
        let params2 = SearchParameter(
            term: "카카오뱅크",
            offset: 30,
            limit: 30
        )
        
        let dto2 = try SearchService.fetch(params: params2)
            .asObservable()
            .toBlocking(timeout: 10)
            .first()
        
        XCTAssertNotNil(dto2)
    }
}

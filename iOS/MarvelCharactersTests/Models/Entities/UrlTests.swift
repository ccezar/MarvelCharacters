//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class UrlTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testUrlConstructor() {
        let url = Url.init(type: "website", url: "https://github.com/jjfernandes87/Challenge/")
    
        XCTAssertNotNil(url.type)
        XCTAssertEqual(url.type, "website")
        XCTAssertNotNil(url.url)
        XCTAssertEqual(url.url, "https://github.com/jjfernandes87/Challenge/")
    }

}

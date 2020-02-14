//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterContentDataContainerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCharacterContentDataContainerConstructor() {
        let data = CharacterContentDataContainer.init(offset: 0, limit: 100, total: 5000, count: 99, results: nil)
        
        XCTAssertNotNil(data.offset)
        XCTAssertEqual(data.offset, 0)
        XCTAssertNotNil(data.limit)
        XCTAssertEqual(data.limit, 100)
        XCTAssertNotNil(data.total)
        XCTAssertEqual(data.total, 5000)
        XCTAssertNotNil(data.count)
        XCTAssertEqual(data.count, 99)
        XCTAssertNil(data.results)
    }

}

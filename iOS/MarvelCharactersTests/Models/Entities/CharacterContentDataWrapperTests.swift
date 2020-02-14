//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterContentDataWrapperTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testCharacterContentDataWrapperConstructor() {
        let container = CharacterContentDataWrapper.init(code: 99,
                                                         status: "ok",
                                                         copyright: "",
                                                         attributionText: "test",
                                                         attributionHTML: "<b>test<b>",
                                                         data: nil,
                                                         etag: "etag test")
        
        XCTAssertNotNil(container.code)
        XCTAssertEqual(container.code, 99)
        XCTAssertNotNil(container.status)
        XCTAssertEqual(container.status, "ok")
        XCTAssertNotNil(container.copyright)
        XCTAssertEqual(container.copyright, "")
        XCTAssertNotNil(container.attributionText)
        XCTAssertEqual(container.attributionText, "test")
        XCTAssertNotNil(container.attributionHTML)
        XCTAssertEqual(container.attributionHTML, "<b>test<b>")
        XCTAssertNotNil(container.etag)
        XCTAssertEqual(container.etag, "etag test")
        XCTAssertNil(container.data)
    }

}

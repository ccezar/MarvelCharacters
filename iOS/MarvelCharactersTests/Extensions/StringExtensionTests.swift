//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class StringExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
        
        
    }

    func testParseStringToMD5ShouldReturnNewString() {
        XCTAssertEqual("CAIO".md5(), "e320420877004828ab0d61d73c08b62c")
        XCTAssertNotEqual("CAIO".md5(), "")

        XCTAssertEqual("StringExtensionTests".md5(), "c46ad4538ae6f1ce34c7146298672266")
        XCTAssertNotEqual("StringExtensionTests".md5(), "")

        XCTAssertEqual("MarvelCharacters".md5(), "a4c53450f02cabb0b72f9731ca2f939e")
        XCTAssertNotEqual("MarvelCharacters".md5(), "")
    }

}

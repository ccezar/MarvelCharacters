//
//  DataExtensionTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 12/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class DataExtensionTests: XCTestCase {

    override func setUp() {
        super.setUp()
    }

    func testLoadUrlLocalJson() {
        if let data = Data.dataFromJson("Url", forClass: Url.self) {
            guard let url = try? JSONDecoder().decode(Url.self, from: data) else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(url.type, "detail")
            XCTAssertEqual(url.url, "http://marvel.com/characters/1009664/thor/featured")
        }
    }
    
    func testLoadCharacterLocalJson() {
        if let data = Data.dataFromJson("Character", forClass: Character.self) {
            guard let character = try? JSONDecoder().decode(Character.self, from: data) else {
                XCTFail()
                return
            }
            
            XCTAssertEqual(character.id, 1009664)
            XCTAssertEqual(character.name, "Thor")
            XCTAssertNotNil(character.thumbnail)
        }
    }

}

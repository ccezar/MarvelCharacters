//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterTests: XCTestCase {

    var character: Character!
    
    override func setUp() {
        character = Character.init(id: 987,
        name: "Test",
        resultDescription: "Description test",
        modified: "2019-02-20",
        resourceURI: nil,
        urls: nil,
        thumbnail: nil)
    }

    func testCharacterConstructor() {
        XCTAssertNotNil(character.id)
        XCTAssertEqual(character.id, 987)
        XCTAssertNotNil(character.name)
        XCTAssertEqual(character.name, "Test")
        XCTAssertNotNil(character.resultDescription)
        XCTAssertEqual(character.resultDescription, "Description test")
        XCTAssertNotNil(character.modified)
        XCTAssertEqual(character.modified, "2019-02-20")
        XCTAssertNil(character.resourceURI)
        XCTAssertNil(character.urls)
        XCTAssertNil(character.thumbnail)
    }
    
    func testCharacterSetFavorite() {
        XCTAssertFalse(character.isFavorite())
        character.setFavorite()
        XCTAssertTrue(character.isFavorite())
    }
    
    func testCharacterUnsetFavorite() {
        XCTAssertFalse(character.isFavorite())
        character.setFavorite()
        XCTAssertTrue(character.isFavorite())
        character.unsetFavorite()
        XCTAssertFalse(character.isFavorite())
    }

}

//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class FavoriteCharacterTests: XCTestCase {

    override func setUp() {

    }

    func testFavoriteCharacterConstructor() {
        let favorite = FavoriteCharacter.init(id: 99,
                                              descriptionText: "Test",
                                              imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg",
                                              name: "Teste Name",
                                              comics: [FavoriteProduction](),
                                              series: [FavoriteProduction]())
        
        XCTAssertNotNil(favorite.id)
        XCTAssertEqual(favorite.id, 99)
        XCTAssertNotNil(favorite.descriptionText)
        XCTAssertEqual(favorite.descriptionText, "Test")
        XCTAssertNotNil(favorite.imageURL)
        XCTAssertEqual(favorite.imageURL, "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg")
        XCTAssertNotNil(favorite.name)
        XCTAssertEqual(favorite.name, "Teste Name")
        XCTAssertEqual(favorite.comics.count, 0)
        XCTAssertEqual(favorite.series.count, 0)
    }
}

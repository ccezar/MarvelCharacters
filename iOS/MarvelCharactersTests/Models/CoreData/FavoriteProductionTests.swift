//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class FavoriteProductionTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    func testFavoriteProductionConstructor() {
        let production = FavoriteProduction.init(imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg", name: "Teste Name")
        
        XCTAssertNotNil(production)
        XCTAssertNotNil(production.imageURL)
        XCTAssertNotNil(production.name)
        XCTAssertEqual(production.imageURL, "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg")
        XCTAssertEqual(production.name, "Teste Name")
    }

}

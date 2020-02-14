//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class CharacterContentTests: XCTestCase {
    
    override func setUp() {
    
    }

    func testCharacterContentConstructor() {
        let characterContent = CharacterContent.init(id: 10, title: "Teste", thumbnail: nil)
        
        XCTAssertNotNil(characterContent.id)
        XCTAssertEqual(characterContent.id, 10)
        XCTAssertNotNil(characterContent.title)
        XCTAssertEqual(characterContent.title, "Teste")
        XCTAssertNil(characterContent.thumbnail)
    }

}

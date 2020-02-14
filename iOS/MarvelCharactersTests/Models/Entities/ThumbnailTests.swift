//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class ThumbnailTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    func testThumbnailConstructor() {
        let thumbnail = Thumbnail.init(path: "https://github.com/jjfernandes87/Challenge/raw/master/iOS/Characters", thumbnailExtension: ".png")
    
        XCTAssertNotNil(thumbnail.path)
        XCTAssertEqual(thumbnail.path, "https://github.com/jjfernandes87/Challenge/raw/master/iOS/Characters")
        XCTAssertNotNil(thumbnail.thumbnailExtension)
        XCTAssertEqual(thumbnail.thumbnailExtension, ".png")
    }

}

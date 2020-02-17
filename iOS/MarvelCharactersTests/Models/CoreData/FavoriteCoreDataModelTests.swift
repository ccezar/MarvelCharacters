//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class FavoriteCoreDataModelTests: XCTestCase {

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

    override func tearDown() {
        FavoriteCoreDataModel.removeAllFavorites()
    }
    
    func testAddFavorite() {
        FavoriteCoreDataModel.addFavorite(character: character)
        guard let favorite = FavoriteCoreDataModel.getFavorites().filter({ $0.id == 987 }).first else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(favorite.id, 987)
    }
    
    func testRemoveFavorite() {
        FavoriteCoreDataModel.addFavorite(character: character)
        FavoriteCoreDataModel.addFavorite(character: Character.init(id: 123,
                                                                    name: "Test",
                                                                    resultDescription: "Description test",
                                                                    modified: "2019-02-20",
                                                                    resourceURI: nil,
                                                                    urls: nil,
                                                                    thumbnail: nil))
        
        FavoriteCoreDataModel.removeFavorite(id: character.id!)
        
        let favorites = FavoriteCoreDataModel.getFavorites()
        
        XCTAssertFalse(favorites.contains(where: { $0.id == character.id! }))
    }
    
    func testListFavorites() {
        FavoriteCoreDataModel.addFavorite(character: character)
        FavoriteCoreDataModel.addFavorite(character: character)
        FavoriteCoreDataModel.addFavorite(character: character)
        
        let favorites = FavoriteCoreDataModel.getFavorites()
        
        XCTAssertEqual(favorites.count, 3)
    }
    
    func testUpdateComics() {
        FavoriteCoreDataModel.addFavorite(character: character)
        let item1 = FavoriteProduction.init(imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg",
                                            name: "Item 1")
        let item2 = FavoriteProduction.init(imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg",
                                            name: "Item 2")
        FavoriteCoreDataModel.updateComics(id: 987, comics: [item1, item2])
        
        guard let favorite = FavoriteCoreDataModel.getFavorites().first else {
            XCTFail()
            return
        }

        XCTAssertEqual(favorite.comics.count, 2)
        XCTAssertEqual(favorite.comics.first?.name, "Item 1")
    }
    
    func testUpdateSeries() {
        FavoriteCoreDataModel.addFavorite(character: character)
        let item1 = FavoriteProduction.init(imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg",
                                            name: "Item 1")
        let item2 = FavoriteProduction.init(imageURL: "http://i.annihil.us/u/prod/marvel/i/mg/5/d0/511e88a20ae34.jpg",
                                            name: "Item 2")
        FavoriteCoreDataModel.updateSeries(id: 987, series: [item1, item2])
        
        guard let favorite = FavoriteCoreDataModel.getFavorites().first else {
            XCTFail()
            return
        }

        XCTAssertEqual(favorite.series.count, 2)
        XCTAssertEqual(favorite.series.first?.name, "Item 1")
    }
}

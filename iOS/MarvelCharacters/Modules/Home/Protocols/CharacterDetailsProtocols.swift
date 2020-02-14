//
//  CharacterDetailsProtocols.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

protocol CharacterDetailsViewToPresenterProtocol: class {
    var view: CharacterDetailsPresenterToViewProtocol? {get set}
    var interactor: CharacterDetailsPresenterToInteractorProtocol? {get set}
    var favorite: FavoriteCharacter? {get set}
    var character: Character? {get set}

    func startFetchingComics(characterId: Int)
    func startFetchingSeries(characterId: Int)
    func isShowingFavorite() -> Bool
    func getImageURL() -> String
    func getName() -> String
    func getDescription() -> String
    func getComics() -> [FavoriteProduction]
    func getSeries() -> [FavoriteProduction]
    func removeFavorite(id: Int)
    func addFavorite(character: Character)
    func addFavorite(favorite: FavoriteCharacter)
}

protocol CharacterDetailsPresenterToViewProtocol: class {
    func showComics()
    func showSeries()
}

protocol CharacterDetailsPresenterToInteractorProtocol: class {
    var presenter: CharacterDetailsInteractorToPresenterProtocol? {get set}
    
    func fetchComics(characterId: Int)
    func fetchSeries(characterId: Int)
}

protocol CharacterDetailsInteractorToPresenterProtocol: class {
    func noticeLoadComicsSuccess(comics: [CharacterContent]?)
    func noticeLoadSeriesSuccess(series: [CharacterContent]?)
    func noticeNoInternetConnection()
}

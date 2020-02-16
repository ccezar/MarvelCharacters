//
//  CharacterDetailsInteractor.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class CharacterDetailsInteractor: CharacterDetailsPresenterToInteractorProtocol {
    var presenter: CharacterDetailsInteractorToPresenterProtocol?
    var api = MarvelAPI()
    var favorite: FavoriteCharacter?
    var character: Character?
    var comics: [CharacterContent]?
    var series: [CharacterContent]?

    func fetchComics(characterId: Int) {
        guard api.isConnectedToInternet() else {
            presenter?.noticeNoInternetConnection()
            return
        }
        
        api.get(endpoint: .charactersComics,
                pathParameters: ["characterId": characterId],
                queryParameters: [:],
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let comicDataWrapper = try? decoder.decode(CharacterContentDataWrapper.self, from: result), let comics = comicDataWrapper.data?.results else {
                return
            }
            
            self?.comics = comics
            self?.presenter?.noticeLoadComicsSuccess()
        }, failure: { [weak self] (statusCode) in

        })
    }
    
    func fetchSeries(characterId: Int) {
        guard api.isConnectedToInternet() else {
            presenter?.noticeNoInternetConnection()
            return
        }
        
        api.get(endpoint: .charactersSeries,
                pathParameters: ["characterId": characterId],
                queryParameters: [:],
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let serieDataWrapper = try? decoder.decode(CharacterContentDataWrapper.self, from: result), let series = serieDataWrapper.data?.results else {
                return
            }
            
            self?.series = series
            self?.presenter?.noticeLoadSeriesSuccess()
        }, failure: { [weak self] (statusCode) in

        })
    }
}

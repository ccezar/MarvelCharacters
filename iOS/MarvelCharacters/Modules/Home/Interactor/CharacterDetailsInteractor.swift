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
            guard let comicDataWrapper = try? decoder.decode(CharacterContentDataWrapper.self, from: result) else {
                return
            }
        
            self?.presenter?.noticeLoadComicsSuccess(comics: comicDataWrapper.data?.results)
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
            guard let serieDataWrapper = try? decoder.decode(CharacterContentDataWrapper.self, from: result) else {
                return
            }
        
            self?.presenter?.noticeLoadSeriesSuccess(series: serieDataWrapper.data?.results)
        }, failure: { [weak self] (statusCode) in

        })
    }
}

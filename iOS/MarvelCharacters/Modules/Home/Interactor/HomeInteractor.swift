//
//  HomeInteractor.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol {
    weak var presenter: HomeInteractorToPresenterProtocol?
    var api = MarvelAPI()
    
    
    func fetchCharacters() {
        api.get(endpoint: .characters,
                pathParameters: nil,
                queryParameters: ["limit": 20],
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self?.presenter?.noticeLoadCharactersFailure()
                return
            }
        
            self?.presenter?.noticeLoadCharactersSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { [weak self] (statusCode) in
            self?.presenter?.noticeLoadCharactersFailure()
        })
    }
    
    func loadCharactersNextPage(page: Int) {
        let queryParameters: [String : Any] = [
            "limit": 20,
            "offset": 20 * (page - 1)
        ]
        
        api.get(endpoint: .characters,
                pathParameters: nil,
                queryParameters: queryParameters,
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self?.presenter?.noticeLoadNextPageFailure()
                return
            }
        
            self?.presenter?.noticeLoadNextPageSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { [weak self] (statusCode) in
            self?.presenter?.noticeLoadNextPageFailure()
        })
    }
    
    func refreshData() {
        api.get(endpoint: .characters,
                pathParameters: nil,
                queryParameters: ["limit": 20],
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self?.presenter?.noticeRefreshFailure()
                return
            }
        
            self?.presenter?.noticeRefreshSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { [weak self] (statusCode) in
            self?.presenter?.noticeRefreshFailure()
        })
    }
}

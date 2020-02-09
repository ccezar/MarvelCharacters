//
//  HomeInteractor.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class HomeInteractor: HomePresenterToInteractorProtocol {
    var presenter: HomeInteractorToPresenterProtocol?
    
    func fetchCharacters() {
        MarvelAPI.get(endpoint: .characters,
                      pathParameters: nil,
                      queryParameters: ["limit": 20],
        success: { (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self.presenter?.noticeFetchCharactersFailure()
                return
            }
        
            self.presenter?.noticeFetchCharactersSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { (statusCode) in
            self.presenter?.noticeFetchCharactersFailure()
        })
    }
    
    func loadCharactersNextPage(page: Int) {
        let queryParameters: [String : Any] = [
            "limit": 20,
            "offset": 20 * (page - 1)
        ]
        
        MarvelAPI.get(endpoint: .characters,
                      pathParameters: nil,
                      queryParameters: queryParameters,
        success: { (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self.presenter?.noticeLoadNextPageFailure()
                return
            }
        
            self.presenter?.noticeLoadNextPageSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { (statusCode) in
            self.presenter?.noticeLoadNextPageFailure()
        })
    }
    
    func refreshData() {
        MarvelAPI.get(endpoint: .characters,
                      pathParameters: nil,
                      queryParameters: ["limit": 20],
        success: { (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self.presenter?.noticeRefreshFailure()
                return
            }
        
            self.presenter?.noticeRefreshSuccess(
                characters: characterDataWrapper.data?.results,
                totalCharacters: characterDataWrapper.data?.count
            )
        }, failure: { (statusCode) in
            self.presenter?.noticeRefreshFailure()
        })
    }
    
    private func loadCharacters(queryParameters: [String : Any]) {
        
    }
}

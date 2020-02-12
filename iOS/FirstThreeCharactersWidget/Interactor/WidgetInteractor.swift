//
//  WidgetInteractor.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 11/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class WidgetInteractor: WidgetPresenterToInteractorProtocol {
    weak var presenter: WidgetInteractorToPresenterProtocol?
    var api = MarvelAPI()
    
    func fetchCharacters() {
        guard api.isConnectedToInternet() else {
            presenter?.noticeNoInternetConnection()
            return
        }
        
        api.get(endpoint: .characters,
                pathParameters: nil,
                queryParameters: [
                    "limit": 3,
                    "orderBy": "name"
                ],
        success: { [weak self] (statusCode, result) in
            let decoder = JSONDecoder()
            guard let characterDataWrapper = try? decoder.decode(CharacterDataWrapper.self, from: result) else {
                self?.presenter?.noticeLoadCharactersFailure()
                return
            }
        
            self?.presenter?.noticeLoadCharactersSuccess(characters: characterDataWrapper.data?.results)
        }, failure: { [weak self] (statusCode) in
            self?.presenter?.noticeLoadCharactersFailure()
        })
    }
}

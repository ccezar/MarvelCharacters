//
//  FavoritesInteractor.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class FavoritesInteractor: FavoritesPresenterToInteractorProtocol {
    weak var presenter: FavoritesInteractorToPresenterProtocol?

    func fetchFavorites() {
        let favorites = FavoriteCoreDataModel.getFavorites()
        
        presenter?.noticeLoadFavoritesSuccess(favorites: favorites)
    }
    
    func removeFavorite(id: Int) {
        FavoriteCoreDataModel.removeFavorite(id: id)
    }
}

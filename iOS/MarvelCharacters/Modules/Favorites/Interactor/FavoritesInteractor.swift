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
    var favorites: [FavoriteCharacter]?

    func fetchFavorites() {
        favorites = FavoriteCoreDataModel.getFavorites()
        
        presenter?.noticeLoadFavoritesSuccess()
    }
    
    func removeFavorite(id: Int) {
        favorites?.removeAll(where: { $0.id == id })
        FavoriteCoreDataModel.removeFavorite(id: id)
    }
}

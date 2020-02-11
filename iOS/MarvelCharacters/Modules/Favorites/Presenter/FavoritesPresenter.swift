//
//  FavoritesPresenter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class FavoritesPresenter: FavoritesViewToPresenterProtocol {
    weak var view: FavoritesPresenterToViewProtocol?
    var interactor: FavoritesPresenterToInteractorProtocol?
    var router: FavoritesPresenterToRouterProtocol?
    var favorites = [FavoriteCharacter]()
    private var currentFitler = ""
    
    func getFavorites() -> [FavoriteCharacter] {
        if currentFitler == "" {
            return favorites
        } else {
            return favorites.filter({ $0.name.starts(with: currentFitler) })
        }
    }
    
    func setCurrentFilter(nameStartsWith: String) {
        currentFitler = nameStartsWith
        view?.showFavorites()
    }
    
    func clearCurrentFilter() {
        currentFitler = ""
        view?.showFavorites()
    }
    
    func startLoadingFavorites() {
        interactor?.fetchFavorites()
    }
    
    func removeFavorite(id: Int) {
        favorites.removeAll(where: { $0.id == id })
        interactor?.removeFavorite(id: id)
    }
    
    func showCharacterDetailController(favorite: FavoriteCharacter, navigationController: UINavigationController) {
        router?.pushToCharacterDetailScreen(favorite: favorite, navigationController: navigationController)
    }
}

extension FavoritesPresenter: FavoritesInteractorToPresenterProtocol {
    func noticeLoadFavoritesSuccess(favorites: [FavoriteCharacter]) {
        self.favorites.removeAll()
        self.favorites.append(contentsOf: favorites)
        
        view?.showFavorites()
    }
    
    func noticeLoadFavoritesFailure() {
        view?.showError()
    }
}

//
//  FavoriteProtocols.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

protocol FavoritesViewToPresenterProtocol: class {
    var view: FavoritesPresenterToViewProtocol? {get set}
    var interactor: FavoritesPresenterToInteractorProtocol? {get set}
    var router: FavoritesPresenterToRouterProtocol? {get set}

    func setCurrentFilter(nameStartsWith: String)
    func clearCurrentFilter()
    func startLoadingFavorites()
    func getFavorites() -> [FavoriteCharacter]
    func removeFavorite(id: Int)
    func showCharacterDetailController(favorite: FavoriteCharacter, navigationController: UINavigationController)
}

protocol FavoritesPresenterToViewProtocol: class {
    func showFavorites()
    func showError()
}

protocol FavoritesPresenterToRouterProtocol: class {
    static func createModule() -> FavoritesViewController
    func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController)
}

protocol FavoritesPresenterToInteractorProtocol: class {
    var presenter: FavoritesInteractorToPresenterProtocol? {get set}
    var favorites: [FavoriteCharacter]? {get set}

    func fetchFavorites()
    func removeFavorite(id: Int)
}

protocol FavoritesInteractorToPresenterProtocol: class {
    func noticeLoadFavoritesSuccess()
    func noticeLoadFavoritesFailure()
}


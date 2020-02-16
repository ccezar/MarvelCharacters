//
//  FavoritesRouter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class FavoritesRouter: FavoritesPresenterToRouterProtocol {
    static func createModule() -> FavoritesViewController {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
            
        let presenter: FavoritesViewToPresenterProtocol & FavoritesInteractorToPresenterProtocol = FavoritesPresenter()
        let interactor: FavoritesPresenterToInteractorProtocol = FavoritesInteractor()
        let router: FavoritesPresenterToRouterProtocol = FavoritesRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }

    func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController) {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController

        let presenter: CharacterDetailsViewToPresenterProtocol & CharacterDetailsInteractorToPresenterProtocol = CharacterDetailsPresenter()
        let interactor: CharacterDetailsPresenterToInteractorProtocol = CharacterDetailsInteractor()
        
        interactor.favorite = favorite
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter


        navigationController.pushViewController(view, animated: true)
        
    }
}

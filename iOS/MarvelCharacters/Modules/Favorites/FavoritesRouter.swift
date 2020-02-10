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
        let view = mainstoryboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
            
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

    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }

    func pushToCharacterDetailScreen(navigationConroller navigationController: UINavigationController) {
        
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController


        navigationController.pushViewController(view, animated: true)
        
    }
}

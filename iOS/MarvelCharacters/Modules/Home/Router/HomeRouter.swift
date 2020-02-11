//
//  HomeRouter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class HomeRouter: HomePresenterToRouterProtocol {
    
    static func createModule() -> HomeViewController {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        view.presenter = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        return view
    }
    
    func pushToCharacterDetailScreen(character: Character, navigationController: UINavigationController) {
        CharacterDetailsRouter.pushToCharacterDetailScreen(character: character, navigationController: navigationController)
    }
    
    func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController) {
        CharacterDetailsRouter.pushToCharacterDetailScreen(favorite: favorite, navigationController: navigationController)
    }
}

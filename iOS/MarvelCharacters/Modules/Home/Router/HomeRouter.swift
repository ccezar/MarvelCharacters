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
        let view = mainstoryboard.instantiateViewController(withIdentifier: "HomeViewController") as! HomeViewController
        
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
    
    static var mainstoryboard: UIStoryboard {
        return UIStoryboard(name:"Main",bundle: Bundle.main)
    }
    
    func pushToCharacterDetailScreen(character: Character, navigationController: UINavigationController) {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController

        let presenter: CharacterDetailsViewToPresenterProtocol & CharacterDetailsInteractorToPresenterProtocol = CharacterDetailsPresenter()
        let interactor: CharacterDetailsPresenterToInteractorProtocol = CharacterDetailsInteractor()
        
        presenter.character = character
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        navigationController.pushViewController(view, animated: true)
    }
    
}

//
//  CharacterDetailsRouter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit

class CharacterDetailsRouter {
    static func pushToCharacterDetailScreen(character: Character, navigationController: UINavigationController) {
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
    
    static func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController) {
        let view = UIStoryboard(name:"Main",bundle: Bundle.main).instantiateViewController(withIdentifier: "CharacterDetailsViewController") as! CharacterDetailsViewController

        let presenter: CharacterDetailsViewToPresenterProtocol & CharacterDetailsInteractorToPresenterProtocol = CharacterDetailsPresenter()
        let interactor: CharacterDetailsPresenterToInteractorProtocol = CharacterDetailsInteractor()
        
        presenter.favorite = favorite
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
        
        navigationController.pushViewController(view, animated: true)
    }
    
}

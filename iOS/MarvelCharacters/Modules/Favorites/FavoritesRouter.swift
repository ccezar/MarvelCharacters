//
//  FavoritesRouter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class FavoritesRouter {
    static func createModule() -> FavoritesViewController {
        let view = mainstoryboard.instantiateViewController(withIdentifier: "FavoritesViewController") as! FavoritesViewController
            
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

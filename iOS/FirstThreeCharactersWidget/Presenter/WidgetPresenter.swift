//
//  WidgetPresenter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 11/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class WidgetPresenter: WidgetViewToPresenterProtocol {
    weak var view: WidgetPresenterToViewProtocol?
    var interactor: WidgetPresenterToInteractorProtocol?
    private var characters = [Character]()
    
    func getCharacters() -> [Character] {
        return characters
    }
    
    func startFetchingCharacters() {
        interactor?.fetchCharacters()
    }
    
    func openAppInCharacterDetailController(character: Character, navigationController: UINavigationController) {
        
    }
}

extension WidgetPresenter: WidgetInteractorToPresenterProtocol {
    func noticeNoInternetConnection() {
        view?.showErrorInternetConnection()
    }
    
    func noticeLoadCharactersSuccess(characters: [Character]?) {
        guard let elements = characters else {
            return
        }
                
        self.characters.removeAll()
        self.characters.append(contentsOf: elements)
        
        view?.showCharacters()
    }
    
    func noticeLoadCharactersFailure() {
        view?.showError()
    }
}

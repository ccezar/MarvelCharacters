//
//  HomePresenter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

class HomePresenter: HomeViewToPresenterProtocol {
    weak var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    var characters = [Character]()
    var hasNextPage = true
    
    func startFetchingCharacters() {
        interactor?.fetchCharacters()
    }
    
    func showCharacterDetailController(navigationController: UINavigationController) {
        router?.pushToCharacterDetailScreen(navigationConroller: navigationController)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func noticeRefreshSuccess(characters: [Character]?, totalCharacters: Int?) {
        guard let elements = characters else {
            return
        }
        
        self.characters.removeAll()
        self.characters.append(contentsOf: elements)
        view?.showCharacters()
    }
    
    func noticeRefreshFailure(){
        view?.showErrorRefresh()
    }
    
    func noticeLoadCharactersSuccess(characters: [Character]?, totalCharacters: Int?) {
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
    
    func noticeLoadNextPageSuccess(characters: [Character]?, totalCharacters: Int?) {
        guard let elements = characters else {
            return
        }
        
        self.characters.append(contentsOf: elements)
        view?.showCharacters()
    }
    
    func noticeLoadNextPageFailure() {
        view?.showErrorAppend()
    }
    
}

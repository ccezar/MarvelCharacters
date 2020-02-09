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
    var view: HomePresenterToViewProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    var router: HomePresenterToRouterProtocol?
    
    func startFetchingCharacters() {
        interactor?.fetchCharacters()
    }
    
    func showCharacterDetailController(navigationController: UINavigationController) {
        router?.pushToCharacterDetailScreen(navigationConroller: navigationController)
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    
    func noticeRefreshSuccess(characters: [Character]?, totalCharacters: Int?) {
        view?.showCharacters(characters: characters)
    }
    
    func noticeRefreshFailure(){
        view?.showErrorRefresh()
    }
    
    func noticeFetchCharactersSuccess(characters: [Character]?, totalCharacters: Int?) {
        view?.showCharacters(characters: characters)
    }
    
    func noticeFetchCharactersFailure(){
        view?.showError()
    }
    
    func noticeLoadNextPageSuccess(characters: [Character]?, totalCharacters: Int?) {
        view?.appendCharacters(characters: characters)
    }
    
    func noticeLoadNextPageFailure() {
        view?.showErrorAppend()
    }
    
}

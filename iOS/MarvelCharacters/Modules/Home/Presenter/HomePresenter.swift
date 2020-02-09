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
    var filteredCharacters = [Character]()
    var searchActive = false
    var page = 1
    private var hasNextPage = true
    private var currentFitler = ""
    
    func getCharacters() -> [Character] {
        if searchActive {
            return filteredCharacters
        } else {
            return characters
        }
    }
    
    func startFetchingCharacters() {
        page = 1
        interactor?.fetchCharacters()
    }
    
    func startLoadingCharactersNextPage() {
        if hasNextPage {
            page += 1
            
            if searchActive {
                interactor?.filterCharacters(nameStartsWith: currentFitler, page: page)
            } else {
                interactor?.loadCharactersNextPage(page: page)
            }
        }
    }
    
    func startFilteringCharacters(nameStartsWith: String) {
        currentFitler = nameStartsWith
        page = 1
        interactor?.filterCharacters(nameStartsWith: currentFitler, page: page)
    }
    
    func showCharacterDetailController(navigationController: UINavigationController) {
        router?.pushToCharacterDetailScreen(navigationConroller: navigationController)
    }
    
    func updateFavoriteStatus(character: Character) {
        
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func noticeNoInternetConnection() {
        view?.showErrorInternetConnection()
    }
    
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
        guard let elements = characters, let totalCharacters = totalCharacters else {
            return
        }
        
        let totalPages = totalCharacters / 20
        hasNextPage = (page + 1) <= totalPages
        
        if searchActive {
            self.filteredCharacters.removeAll()
            self.filteredCharacters.append(contentsOf: elements)
        } else {
            self.characters.removeAll()
            self.characters.append(contentsOf: elements)
        }
        
        view?.showCharacters()
    }
    
    func noticeLoadCharactersFailure() {
        view?.showError()
    }
    
    func noticeLoadNextPageSuccess(characters: [Character]?, totalCharacters: Int?) {
        guard let elements = characters, let totalCharacters = totalCharacters else {
            return
        }
        
        let totalPages = totalCharacters / 20
        hasNextPage = (page + 1) <= totalPages
        
        if searchActive {
            self.filteredCharacters.append(contentsOf: elements)
        } else {
            self.characters.append(contentsOf: elements)
        }
        
        view?.showCharacters()
    }
    
    func noticeLoadNextPageFailure() {
        view?.showErrorAppend()
    }
    
    func noticeFilterCharactersFailure() {
        view?.showErrorFilter()
    }
}

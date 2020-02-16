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
    var searchActive = false
    var page = 1
    private var hasNextPage = true
    private var currentFitler = ""
    
    func getCharacters() -> [Character] {
        if searchActive {
            return interactor?.filteredCharacters ?? [Character]()
        } else {
            return interactor?.characters ?? [Character]()
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
    
    func showCharacterDetailController(character: Character, navigationController: UINavigationController) {
        if character.isFavorite() {
            guard let id = character.id, let thumbnail = character.thumbnail, let path = thumbnail.path, let thumbnailExtension = thumbnail.thumbnailExtension else {
                return
            }
            
            let favorite = FavoriteCharacter.init(id: id,
                                                  descriptionText: character.resultDescription ?? "",
                                                  imageURL: "\(path).\(thumbnailExtension)",
                                                  name: character.name ?? "",
                                                  comics: [FavoriteProduction](),
                                                  series: [FavoriteProduction]())
            router?.pushToCharacterDetailScreen(favorite: favorite, navigationController: navigationController)
        } else {
            router?.pushToCharacterDetailScreen(character: character, navigationController: navigationController)
        }
    }
    
    func updateFavoriteStatus(character: Character) {
        guard let id = character.id  else {
            return
        }
        
        if !character.isFavorite() {
            FavoriteCoreDataModel.removeFavorite(id: id)
        } else {
            FavoriteCoreDataModel.addFavorite(character: character)
        }
    }
    
    func updateCharactersFavoriteStatus() {
        setFavorites(interactor?.characters ?? [Character]())
    }
    
    private func setFavorites(_ characters: [Character]) {
        let favorites = FavoriteCoreDataModel.getFavorites()
        for character in characters {
            if favorites.contains(where: { $0.id == character.id! }) {
                character.setFavorite()
            } else {
                character.unsetFavorite()
            }
        }
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func noticeNoInternetConnection() {
        view?.showErrorInternetConnection()
    }
    
    func noticeRefreshSuccess(totalCharacters: Int?) {
        guard let elements = interactor?.characters else {
            return
        }
        
        setFavorites(elements)
        view?.showCharacters()
    }
    
    func noticeRefreshFailure(){
        view?.showErrorRefresh()
    }
    
    func noticeLoadCharactersSuccess(totalCharacters: Int?) {
        guard let elements = interactor?.characters, let totalCharacters = totalCharacters else {
            return
        }
        
        setFavorites(elements)
        
        let totalPages = totalCharacters / 20
        hasNextPage = (page + 1) <= totalPages
        
        view?.showCharacters()
    }
    
    func noticeLoadCharactersFailure() {
        view?.showError()
    }
    
    func noticeLoadNextPageSuccess(totalCharacters: Int?) {
        guard let elements = interactor?.characters, let totalCharacters = totalCharacters else {
            return
        }
        
        setFavorites(elements)

        let totalPages = totalCharacters / 20
        hasNextPage = (page + 1) <= totalPages
        
        view?.showCharacters()
    }
    
    func noticeLoadNextPageFailure() {
        view?.showErrorAppend()
    }
    
    func noticeFilterCharactersFailure() {
        view?.showErrorFilter()
    }
}

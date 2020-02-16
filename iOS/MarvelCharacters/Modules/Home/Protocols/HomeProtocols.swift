//
//  HomeProtocols.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

protocol HomeViewToPresenterProtocol: class {
    var view: HomePresenterToViewProtocol? {get set}
    var interactor: HomePresenterToInteractorProtocol? {get set}
    var router: HomePresenterToRouterProtocol? {get set}
    var page: Int {get set}
    var searchActive: Bool {get set}

    func getCharacters() -> [Character]
    func startFilteringCharacters(nameStartsWith: String)
    func startFetchingCharacters()
    func startLoadingCharactersNextPage()
    func updateFavoriteStatus(character: Character)
    func updateCharactersFavoriteStatus()
    func showCharacterDetailController(character: Character, navigationController: UINavigationController)
}

protocol HomePresenterToViewProtocol: class {
    func showCharacters()
    func showErrorInternetConnection()
    func showError()
    func showErrorFilter()
    func showErrorAppend()
    func showErrorRefresh()
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule() -> HomeViewController
    func pushToCharacterDetailScreen(character: Character, navigationController: UINavigationController)
    func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    var characters: [Character] {get set}
    var filteredCharacters: [Character] {get set}

    func filterCharacters(nameStartsWith: String, page: Int)
    func fetchCharacters()
    func loadCharactersNextPage(page: Int)
    func refreshData()
}

protocol HomeInteractorToPresenterProtocol: class {
    func noticeNoInternetConnection()
    func noticeRefreshSuccess(totalCharacters: Int?)
    func noticeRefreshFailure()
    func noticeLoadCharactersSuccess(totalCharacters: Int?)
    func noticeFilterCharactersFailure()
    func noticeLoadCharactersFailure()
    func noticeLoadNextPageSuccess(totalCharacters: Int?)
    func noticeLoadNextPageFailure()
}

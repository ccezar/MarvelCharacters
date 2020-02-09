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
    
    func startFetchingCharacters()
    func showCharacterDetailController(navigationController: UINavigationController)
}

protocol HomePresenterToViewProtocol: class {
    func showCharacters(characters: [Character]?)
    func appendCharacters(characters: [Character]?)
    func showError()
    func showErrorAppend()
    func showErrorRefresh()
}

protocol HomePresenterToRouterProtocol: class {
    static func createModule() -> HomeViewController
    func pushToCharacterDetailScreen(navigationConroller: UINavigationController)
}

protocol HomePresenterToInteractorProtocol: class {
    var presenter: HomeInteractorToPresenterProtocol? {get set}
    func fetchCharacters()
    func loadCharactersNextPage(page: Int)
    func refreshData()
}

protocol HomeInteractorToPresenterProtocol: class {
    func noticeRefreshSuccess(characters: [Character]?, totalCharacters: Int?)
    func noticeRefreshFailure()
    func noticeFetchCharactersSuccess(characters: [Character]?, totalCharacters: Int?)
    func noticeFetchCharactersFailure()
    func noticeLoadNextPageSuccess(characters: [Character]?, totalCharacters: Int?)
    func noticeLoadNextPageFailure()
}

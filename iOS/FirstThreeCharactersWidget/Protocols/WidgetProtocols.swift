//
//  WidgetProtocols.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 11/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation
import UIKit

protocol WidgetViewToPresenterProtocol: class {
    var view: WidgetPresenterToViewProtocol? {get set}
    var interactor: WidgetPresenterToInteractorProtocol? {get set}
    
    func getCharacters() -> [Character]
    func startFetchingCharacters()
    func openAppInCharacterDetailController(character: Character, navigationController: UINavigationController)
}

protocol WidgetPresenterToViewProtocol: class {
    func showCharacters()
    func showErrorInternetConnection()
    func showError()
}

protocol WidgetPresenterToInteractorProtocol: class {
    var presenter: WidgetInteractorToPresenterProtocol? {get set}
    
    func fetchCharacters()
}

protocol WidgetInteractorToPresenterProtocol: class {
    func noticeLoadCharactersSuccess(characters: [Character]?)
    func noticeLoadCharactersFailure()
    func noticeNoInternetConnection()
}

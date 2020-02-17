//
//  MarvelCharactersTests.swift
//  MarvelCharactersTests
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import XCTest
@testable import MarvelCharacters

class HomePresenterTests: XCTestCase {

    var homePresenter: HomePresenter!
    
    class MockInteractor: HomePresenterToInteractorProtocol {
        var presenter: HomeInteractorToPresenterProtocol?
        var characters: [Character]?
        var filteredCharacters: [Character]?
        
        init() {
            characters = [
                Character.init(id: 1, name: "Test1", resultDescription: "Test1 result description", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil),
                Character.init(id: 2, name: "Test2", resultDescription: "Test2", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil),
                Character.init(id: 3, name: "Test3", resultDescription: "Test3", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)
            ]
        }
        
        func filterCharacters(nameStartsWith: String, page: Int) {
            filteredCharacters = characters?.filter({ $0.name!.starts(with: nameStartsWith) })
        }
        
        func fetchCharacters() {
            
        }
        
        func loadCharactersNextPage(page: Int) {
            characters?.append(contentsOf: [
                Character.init(id: 4, name: "Test4", resultDescription: "Test4 result description", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil),
                Character.init(id: 5, name: "Test5", resultDescription: "Test5", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil),
                Character.init(id: 6, name: "Test6", resultDescription: "Test6", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)
            ])
        }
        
        func refreshData() {
            characters = [
                Character.init(id: 1, name: "Test1", resultDescription: "Test1 result description", modified: nil, resourceURI: nil, urls: nil, thumbnail: nil)
            ]
        }
    }
    
    class MockRouter: HomePresenterToRouterProtocol {
        static func createModule() -> HomeViewController {
            return HomeViewController()
        }
        
        func pushToCharacterDetailScreen(character: Character, navigationController: UINavigationController) {
            
        }
        
        func pushToCharacterDetailScreen(favorite: FavoriteCharacter, navigationController: UINavigationController) {
            
        }
    }
    
    var mockInteractor: MockInteractor!
    var mockRouter: MockRouter!

    override func setUp() {
        super.setUp()
        mockInteractor = MockInteractor()
        mockRouter = MockRouter()
        homePresenter = HomePresenter()
        homePresenter.interactor = mockInteractor
        homePresenter.router = mockRouter
    }
        
    func testStartFetchingCharacters() {
        homePresenter.startFetchingCharacters()
        XCTAssertNotNil(mockInteractor.characters)
        XCTAssertEqual(mockInteractor.characters?.count, 3)
        XCTAssertEqual(mockInteractor.characters?.first?.name, "Test1")
        XCTAssertEqual(mockInteractor.characters?.last?.name, "Test3")
    }
        
    func testStartFilteringCharacters() {
        homePresenter.startFilteringCharacters(nameStartsWith: "Test1")
        XCTAssertNotNil(mockInteractor.filteredCharacters)
        XCTAssertEqual(mockInteractor.filteredCharacters!.count, 1)
        XCTAssertEqual(mockInteractor.filteredCharacters!.first!.resultDescription, "Test1 result description")
    }
        
    func testStartLoadingCharactersNextPage() {
        homePresenter.searchActive = false
        homePresenter.startLoadingCharactersNextPage()
        XCTAssertNotNil(mockInteractor.characters)
        XCTAssertEqual(mockInteractor.characters!.count, 6)
        XCTAssertEqual(mockInteractor.characters!.last!.resultDescription, "Test6")
    }
        
    func testGetCharacters() {
        let characters = homePresenter.getCharacters()
        XCTAssertEqual(characters.count, 3)
        XCTAssertEqual(characters.last!.resultDescription, "Test3")
    }
        
    func testUpdateCharactersFavoriteStatus() {
        guard let character = homePresenter.getCharacters().first else {
            XCTFail()
            return
        }
        
        FavoriteCoreDataModel.addFavorite(character: character)
        
        homePresenter.updateCharactersFavoriteStatus()
        
        let characters = homePresenter.getCharacters()
        XCTAssertEqual(characters.filter({ $0.isFavorite() }).count, 1)
        
        FavoriteCoreDataModel.removeFavorite(id: 1)
    }

}

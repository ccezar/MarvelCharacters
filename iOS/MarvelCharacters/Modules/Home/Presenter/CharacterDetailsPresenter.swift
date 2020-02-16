//
//  CharacterDetailsPresenter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class CharacterDetailsPresenter: CharacterDetailsViewToPresenterProtocol {
    var view: CharacterDetailsPresenterToViewProtocol?
    var interactor: CharacterDetailsPresenterToInteractorProtocol?
    
    func getFavorite() -> FavoriteCharacter? {
        return interactor?.favorite
    }
    
    func getCharacter() -> Character? {
        return interactor?.character
    }
    
    func isShowingFavorite() -> Bool {
        return interactor?.favorite != nil
    }
    
    func startFetchingComics(characterId: Int) {
        interactor?.fetchComics(characterId: characterId)
    }
    
    func startFetchingSeries(characterId: Int) {
        interactor?.fetchSeries(characterId: characterId)
    }
    
    func getImageURL() -> String {
        if let favorite = interactor?.favorite { return favorite.imageURL }
        
        if let thumbnail = interactor?.character?.thumbnail, let path = thumbnail.path, let thumbnailExtension = thumbnail.thumbnailExtension {
            return "\(path).\(thumbnailExtension)"
        }

        return ""
    }
    
    func getName() -> String {
        if let favorite = interactor?.favorite { return favorite.name }
        if let character = interactor?.character { return character.name ?? "" }
        
        return ""
    }
    
    func getDescription() -> String {
        if let favorite = interactor?.favorite { return favorite.descriptionText }
        if let character = interactor?.character { return character.resultDescription ?? "" }
        
        return ""
    }
    
    func getComics() -> [FavoriteProduction] {
        if let favorite = interactor?.favorite { return favorite.comics }

        guard let comics = interactor?.comics else {
            return [FavoriteProduction]()
        }
        
        var result = [FavoriteProduction]()
        for comic in comics {
            if let item = transformComicToFavoriteProduction(comic: comic) {
                result.append(item)
            }
        }
        
        return result
    }
    
    func getSeries() -> [FavoriteProduction] {
        if let favorite = interactor?.favorite { return favorite.series }

        guard let series = interactor?.series else {
            return [FavoriteProduction]()
        }
        
        var result = [FavoriteProduction]()
        for serie in series {
            if let item = transformSerieToFavoriteProduction(serie: serie) {
                result.append(item)
            }
        }
        
        return result
    }
    
    private func transformComicToFavoriteProduction(comic: CharacterContent) -> FavoriteProduction? {
        if let thumbnail = comic.thumbnail, let path = thumbnail.path, let thumbnailExtension = thumbnail.thumbnailExtension, let title = comic.title {
            let imageURL = "\(path).\(thumbnailExtension)"
            return FavoriteProduction(imageURL: imageURL, name: title)
        }
        
        return nil
    }
    
    private func transformSerieToFavoriteProduction(serie: CharacterContent) -> FavoriteProduction? {
        if let thumbnail = serie.thumbnail, let path = thumbnail.path, let thumbnailExtension = thumbnail.thumbnailExtension, let title = serie.title {
            let imageURL = "\(path).\(thumbnailExtension)"
            return FavoriteProduction(imageURL: imageURL, name: title)
        }
        
        return nil
    }
    
    func removeFavorite(id: Int) {
        FavoriteCoreDataModel.removeFavorite(id: id)
    }
    
    func addFavorite(character: Character) {
        FavoriteCoreDataModel.addFavorite(character: character)
    }
    
    func addFavorite(favorite: FavoriteCharacter) {
        
        let thumb = favorite.imageURL.split(separator: ".")
        let character = Character.init(id: favorite.id,
                                       name: favorite.name,
                                       resultDescription: favorite.descriptionText,
                                       modified: nil,
                                       resourceURI: nil,
                                       urls: nil,
                                       thumbnail: Thumbnail.init(path: String(thumb.first!),
                                                                 thumbnailExtension: String(thumb.last!)))
        
        FavoriteCoreDataModel.addFavorite(character: character)
    }
}

extension CharacterDetailsPresenter: CharacterDetailsInteractorToPresenterProtocol {
    func noticeLoadComicsSuccess() {
        if let comics = interactor?.comics, comics.count > 0 {
            if let favorite = interactor?.favorite {
                for comic in comics {
                    if let item = transformComicToFavoriteProduction(comic: comic) {
                        favorite.comics.append(item)
                    }
                }
                
                FavoriteCoreDataModel.updateComics(id: favorite.id, comics: favorite.comics)
            }
            
            view?.showComics()
        }
    }
    
    func noticeLoadSeriesSuccess() {
        if let series = interactor?.series, series.count > 0 {
            if let favorite = interactor?.favorite {
                for serie in series {
                    if let item = transformSerieToFavoriteProduction(serie: serie) {
                        favorite.series.append(item)
                    }
                }
                
                FavoriteCoreDataModel.updateSeries(id: favorite.id, series: favorite.series)
            }
            
            view?.showSeries()
        }
    }
    
    func noticeNoInternetConnection() {
        
    }
}

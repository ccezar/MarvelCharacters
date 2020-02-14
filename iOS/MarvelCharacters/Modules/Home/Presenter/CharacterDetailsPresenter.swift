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
    var favorite: FavoriteCharacter?
    var character: Character?
    var comics = [CharacterContent]()
    var series = [CharacterContent]()

    func isShowingFavorite() -> Bool {
        return favorite != nil
    }
    
    func startFetchingComics(characterId: Int) {
        interactor?.fetchComics(characterId: characterId)
    }
    
    func startFetchingSeries(characterId: Int) {
        interactor?.fetchSeries(characterId: characterId)
    }
    
    func getImageURL() -> String {
        if let favorite = favorite { return favorite.imageURL }
        
        if let thumbnail = character?.thumbnail, let path = thumbnail.path, let thumbnailExtension = thumbnail.thumbnailExtension {
            return "\(path).\(thumbnailExtension)"
        }

        return ""
    }
    
    func getName() -> String {
        if let favorite = favorite { return favorite.name }
        if let character = character { return character.name ?? "" }
        
        return ""
    }
    
    func getDescription() -> String {
        if let favorite = favorite { return favorite.descriptionText }
        if let character = character { return character.resultDescription ?? "" }
        
        return ""
    }
    
    func getComics() -> [FavoriteProduction] {
        if let favorite = favorite { return favorite.comics }

        var result = [FavoriteProduction]()
        for comic in comics {
            if let item = transformComicToFavoriteProduction(comic: comic) {
                result.append(item)
            }
        }
        
        return result
    }
    
    func getSeries() -> [FavoriteProduction] {
        if let favorite = favorite { return favorite.series }

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
    func noticeLoadComicsSuccess(comics: [CharacterContent]?) {
        if let comics = comics, comics.count > 0 {
            if let _ = character {
                self.comics.removeAll()
                self.comics.append(contentsOf: comics)
            } else if let favorite = favorite {
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
    
    func noticeLoadSeriesSuccess(series: [CharacterContent]?) {
        if let series = series, series.count > 0 {
            if let _ = character {
                self.series.removeAll()
                self.series.append(contentsOf: series)
            } else if let favorite = favorite {
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

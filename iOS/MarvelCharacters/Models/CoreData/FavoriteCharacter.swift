//
//  FavoriteCharacter.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 09/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

public class FavoriteCharacter: NSObject, NSCoding {
    
    public var id: Int = 0
    public var descriptionText: String = ""
    public var imageURL: String = ""
    public var name: String = ""
    public var comics: [FavoriteProduction] = []
    public var series: [FavoriteProduction] = []

    enum Key: String {
        case id = "id"
        case descriptionText = "descriptionText"
        case imageURL = "imageURL"
        case name = "name"
        case comics = "comics"
        case series = "series"
    }
    
    init(id: Int, descriptionText: String, imageURL: String, name: String, comics: [FavoriteProduction], series: [FavoriteProduction]) {
        self.id = id
        self.descriptionText = descriptionText
        self.imageURL = imageURL
        self.name = name
        self.comics = comics
        self.series = series
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: Key.id.rawValue)
        aCoder.encode(descriptionText, forKey: Key.descriptionText.rawValue)
        aCoder.encode(imageURL, forKey: Key.imageURL.rawValue)
        aCoder.encode(name, forKey: Key.name.rawValue)
        aCoder.encode(comics, forKey: Key.comics.rawValue)
        aCoder.encode(series, forKey: Key.series.rawValue)
    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mId = aDecoder.decodeInt32(forKey: Key.id.rawValue)
        let mDescriptionText = aDecoder.decodeObject(forKey: Key.descriptionText.rawValue) as! String
        let mImageURL = aDecoder.decodeObject(forKey: Key.imageURL.rawValue) as! String
        let mName = aDecoder.decodeObject(forKey: Key.name.rawValue) as! String
        let mComics = aDecoder.decodeObject(forKey: Key.comics.rawValue) as! [FavoriteProduction]
        let mSeries = aDecoder.decodeObject(forKey: Key.series.rawValue) as! [FavoriteProduction]

        self.init(id: Int(mId), descriptionText: mDescriptionText, imageURL: mImageURL, name: mName, comics: mComics, series: mSeries)
    }
    
    
}

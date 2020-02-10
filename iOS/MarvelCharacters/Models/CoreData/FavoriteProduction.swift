//
//  FavoriteProduction.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 09/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

public class FavoriteProduction: NSObject, NSCoding {
    
    public var imageURL: String = ""
    public var name: String = ""
    
    enum Key: String {
        case imageURL = "imageURL"
        case name = "name"
    }
    
    init(imageURL: String, name: String) {
        self.imageURL = imageURL
        self.name = name
    }
    
    public override init() {
        super.init()
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(imageURL, forKey: Key.imageURL.rawValue)
        aCoder.encode(name, forKey: Key.name.rawValue)

    }
    
    public required convenience init?(coder aDecoder: NSCoder) {
        let mImageURL = aDecoder.decodeObject(forKey: Key.imageURL.rawValue) as! String
        let mName = aDecoder.decodeObject(forKey: Key.name.rawValue) as! String
        
        self.init(imageURL: mImageURL, name: mName)
    }
}

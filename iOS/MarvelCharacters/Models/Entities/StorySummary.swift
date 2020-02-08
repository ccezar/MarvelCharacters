//
//  StorySummary.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class StorySummary: Codable {
    let resourceURI, name, type: String?

    init(resourceURI: String?, name: String?, type: String?) {
        self.resourceURI = resourceURI
        self.name = name
        self.type = type
    }
}

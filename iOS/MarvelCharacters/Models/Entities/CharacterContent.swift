//
//  Serie.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class CharacterContent: Codable {
    let id: Int?
    let title: String?
    let thumbnail: Thumbnail?

    init(id: Int?, title: String?, thumbnail: Thumbnail?) {
        self.id = id
        self.title = title
        self.thumbnail = thumbnail
    }
}

//
//  Url.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class Url: Codable {
    let type, url: String?

    init(type: String?, url: String?) {
        self.type = type
        self.url = url
    }
}

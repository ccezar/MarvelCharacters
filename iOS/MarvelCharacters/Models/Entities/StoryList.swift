//
//  StoryList.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class StoryList: Codable {
    let available, returned: Int?
    let collectionURI: String?
    let items: [StorySummary]?

    init(available: Int?, returned: Int?, collectionURI: String?, items: [StorySummary]?) {
        self.available = available
        self.returned = returned
        self.collectionURI = collectionURI
        self.items = items
    }
}

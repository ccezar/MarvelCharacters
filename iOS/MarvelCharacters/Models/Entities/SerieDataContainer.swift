//
//  SerieDataContainer.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class SerieDataContainer: Codable {
    let offset, limit, total, count: Int?
    let results: [Serie]?

    init(offset: Int?, limit: Int?, total: Int?, count: Int?, results: [Serie]?) {
        self.offset = offset
        self.limit = limit
        self.total = total
        self.count = count
        self.results = results
    }
}

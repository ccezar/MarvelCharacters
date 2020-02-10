//
//  SerieDataWrapper.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class SerieDataWrapper: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let data: SerieDataContainer?
    let etag: String?
    
    init(code: Int?, status: String?, copyright: String?, attributionText: String?, attributionHTML: String?,
         data: SerieDataContainer?, etag: String?) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.data = data
        self.etag = etag
    }
}

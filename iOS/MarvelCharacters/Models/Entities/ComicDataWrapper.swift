//
//  ComicList.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class ComicDataWrapper: Codable {
    let code: Int?
    let status, copyright, attributionText, attributionHTML: String?
    let data: ComicDataContainer?
    let etag: String?
    
    init(code: Int?, status: String?, copyright: String?, attributionText: String?, attributionHTML: String?,
         data: ComicDataContainer?, etag: String?) {
        self.code = code
        self.status = status
        self.copyright = copyright
        self.attributionText = attributionText
        self.attributionHTML = attributionHTML
        self.data = data
        self.etag = etag
    }
}

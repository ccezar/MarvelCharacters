//
//  Character.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

class Character: Codable {
    let id: Int?
    let name, resultDescription, modified: String?
    let resourceURI: String?
    let urls: [Url]?
    let thumbnail: Thumbnail?
    let comics: ComicList?
    let stories: StoryList?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case resultDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories
    }

    init(id: Int?, name: String?, resultDescription: String?, modified: String?, resourceURI: String?,
         urls: [Url]?, thumbnail: Thumbnail?, comics: ComicList?, stories: StoryList?) {
        self.id = id
        self.name = name
        self.resultDescription = resultDescription
        self.modified = modified
        self.resourceURI = resourceURI
        self.urls = urls
        self.thumbnail = thumbnail
        self.comics = comics
        self.stories = stories
    }
}

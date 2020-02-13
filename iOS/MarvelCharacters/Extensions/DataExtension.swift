//
//  DataExtension.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 12/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import Foundation

extension Data {
    static func dataFromJson(_ jsonName: String, forClass classType: AnyClass) -> Data? {
        return Data.dataFromJson(jsonName, forBundle: Bundle(for: classType))
    }
    
    static func dataFromJson(_ jsonName: String, forBundle bundle: Bundle) -> Data? {
        guard let path = bundle.path(forResource: jsonName, ofType: "json") else { return nil }
        guard let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe) else { return nil }
        return data
    }
}

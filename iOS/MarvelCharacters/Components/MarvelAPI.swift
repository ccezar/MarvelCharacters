//
//  MarvelAPI.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire

typealias success = ((_ statusCode: Int, _ result: Data) -> Void)
typealias failure = ((_ statusCode: Int) -> Void)

class MarvelAPI: NSObject {
    private static let publicKey = "eaf6a86b375ee3572f5f1517dfbcc9a1"
    private static let privateKey = "7b95c96da943e542f4c67038fd3cfef3a64674d1"
    
    class func getCharactersByPage(page: Int, success: @escaping success, failure: @escaping failure) {
        let tokens = generateRequestTokens()

        Alamofire.request(
            "http://gateway.marvel.com/v1/public/characters",
            method: .get,
            parameters: [
                "limit": "15",
                "offset": 15 * (page - 1),
                "apikey": publicKey,
                "ts" : tokens.1,
                "hash" : tokens.0
            ]
        ).validate(statusCode: 200..<300)
        .responseJSON(completionHandler: { (response) in
            if let statusCode = response.response?.statusCode, let data = response.data, response.result.isSuccess {
                success(statusCode, data)
            } else {
                failure(response.response?.statusCode ?? 500)
            }
        })
    }
    
    class func getComicsByCharacters(characterId: Int, success: @escaping success, failure: @escaping failure) {
        let tokens = generateRequestTokens()
        
        Alamofire.request(
            "http://gateway.marvel.com/v1/public/characters/\(characterId)/comics",
            method: .get,
            parameters: [
                "characterId": characterId,
                "apikey": publicKey,
                "ts" : tokens.1,
                "hash" : tokens.0
            ]
        ).validate(statusCode: 200..<300)
        .responseJSON(completionHandler: { (response) in
            if let statusCode = response.response?.statusCode,
               let data = response.data, response.result.isSuccess {
                success(statusCode, data)
            } else {
                failure(response.response?.statusCode ?? 500)
            }
        })
    }
    
    class func getSeriesByCharacters(characterId: Int, success: @escaping success, failure: @escaping failure) {
        let tokens = generateRequestTokens()
        
        Alamofire.request(
            "http://gateway.marvel.com/v1/public/characters/\(characterId)/series",
            method: .get,
            parameters: [
                "characterId": characterId,
                "apikey": publicKey,
                "ts" : tokens.1,
                "hash" : tokens.0
            ]
        ).validate(statusCode: 200..<300)
        .responseJSON(completionHandler: { (response) in
            if let statusCode = response.response?.statusCode,
               let data = response.data, response.result.isSuccess {
                success(statusCode, data)
            } else {
                failure(response.response?.statusCode ?? 500)
            }
        })
    }
    
    private class func generateRequestTokens() -> (String, TimeInterval) {
        let ts = NSDate().timeIntervalSince1970
        let hash: String = ("\(ts)\(privateKey)\(publicKey)").md5()
        
        return (hash, ts)
    }
}

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

enum Endpoint : String {
    case characters = "characters",
    charactersComics = "characters/{characterId}/comics",
    charactersSeries = "characters/{characterId}/series"
}

protocol MarvelAPIProtocol: class {
    func isConnectedToInternet() -> Bool
    func get(endpoint: Endpoint, pathParameters: Parameters?, queryParameters: Parameters,
                   success: @escaping success, failure: @escaping failure)
}

open class MarvelAPI: MarvelAPIProtocol {
    private let basePath = "http://gateway.marvel.com/v1/public/"
    private let publicKey = "eaf6a86b375ee3572f5f1517dfbcc9a1"
    private let privateKey = "7b95c96da943e542f4c67038fd3cfef3a64674d1"
    
    func isConnectedToInternet() -> Bool {
        return NetworkReachabilityManager()!.isReachable
    }
    
    func get(endpoint: Endpoint, pathParameters: Parameters?, queryParameters: Parameters,
                   success: @escaping success, failure: @escaping failure) {
        let tokens = generateRequestTokens()

        var parameters = queryParameters
        parameters["apikey"] = publicKey
        parameters["ts"] = tokens.1
        parameters["hash"] = tokens.0
            
        Alamofire.request(
            buildUrl(endpoint, pathParameters),
            method: .get,
            parameters: parameters
        ).validate(statusCode: 200..<300)
         .responseJSON(completionHandler: { [weak self] (response) in
            if let statusCode = response.response?.statusCode, let data = response.data, response.result.isSuccess {
                success(statusCode, data)
            } else {
                failure(response.response?.statusCode ?? 500)
            }
         })
    }
    
    private func buildUrl(_ endpoint: Endpoint, _ pathParameters: Parameters?) -> String {
        guard let pathParameters = pathParameters else {
            return "\(basePath)\(endpoint.rawValue)"
        }
        
        var endpointPath = endpoint.rawValue
        
        for item in pathParameters {
            endpointPath = endpointPath.replacingOccurrences(of: "{\(item.key)}", with: "\(item.value)")
        }
        
        return "\(basePath)\(endpointPath)"
    }
    
    private func generateRequestTokens() -> (String, TimeInterval) {
        let ts = NSDate().timeIntervalSince1970
        let hash: String = ("\(ts)\(privateKey)\(publicKey)").md5()
        
        return (hash, ts)
    }
}

//
//  ViewController.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        testAPICall()
    }

    func testAPICall() {
        MarvelAPI.getCharactersByPage(page: 1, success: { (statusCode, data) in
            print(data!)

            
        }) { (statusCode) in

        }
        
        
    }
}


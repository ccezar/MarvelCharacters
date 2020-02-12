//
//  TodayViewController.swift
//  FirstThreeCharactersWidget
//
//  Created by Caio Cezar Lopes dos Santos on 11/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import NotificationCenter

class WidgetViewController: UIViewController, NCWidgetProviding {
        
    @IBOutlet weak var dataStackView: UIStackView!
    
    @IBOutlet weak var firstCharacterView: UIView!
    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var firstCharacterLabel: UILabel!
    
    @IBOutlet weak var secondCharacterView: UIView!
    @IBOutlet weak var secondImageView: UIImageView!
    @IBOutlet weak var secondCharacterLabel: UILabel!
    
    @IBOutlet weak var thirdCharacterView: UIView!
    @IBOutlet weak var thirdImageView: UIImageView!
    @IBOutlet weak var thirdCharacterLabel: UILabel!
    
    @IBOutlet weak var errorView: UIView!
    @IBOutlet weak var messageErrorLabel: UILabel!

    var presenter: WidgetViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        presenter?.startFetchingCharacters()
    }
        
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    private func showErrorView(message: String) {
        errorView.isHidden = false
        dataStackView.isHidden = true
        
        messageErrorLabel.text = message
    }
    
    private func hideErrorView() {
        errorView.isHidden = true
        dataStackView.isHidden = false
    }
}

extension WidgetViewController: WidgetPresenterToViewProtocol {
    func showErrorInternetConnection() {
        showErrorView(message: "Looks like there is no internet connection")
    }
    
    func showCharacters() {
        if let presenter = presenter, presenter.getCharacters().count > 0 {
            let count = presenter.getCharacters().count
            
            firstCharacterLabel.text = presenter.getCharacters()[0].name
            
            if count > 1 {
                secondCharacterLabel.text = presenter.getCharacters()[0].name

            } else {
                secondCharacterView.isHidden = true
            }
            
            if count > 2 {
                thirdCharacterLabel.text = presenter.getCharacters()[0].name

            } else {
                thirdCharacterView.isHidden = true
            }
            
            hideErrorView()
        } else {
            showErrorView(message: "Looks like there is no characters to list.")
        }
    }
    
    func showError() {
        showErrorView(message: "An error has occurred, please try again.")
    }
}

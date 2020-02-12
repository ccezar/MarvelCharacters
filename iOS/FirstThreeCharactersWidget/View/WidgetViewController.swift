//
//  TodayViewController.swift
//  FirstThreeCharactersWidget
//
//  Created by Caio Cezar Lopes dos Santos on 11/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import NotificationCenter
import Alamofire
import AlamofireImage

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
        
        loadModule()

        presenter?.startFetchingCharacters()
    }
    
    func loadModule() {
        let view = self
        let presenter: WidgetViewToPresenterProtocol & WidgetInteractorToPresenterProtocol = WidgetPresenter()
        let interactor: WidgetPresenterToInteractorProtocol = WidgetInteractor()
        
        view.presenter = presenter
        presenter.view = view
        presenter.interactor = interactor
        interactor.presenter = presenter
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
    
    // function which is triggered when handleTap is called
    @objc func handleTap(_ sender: MyTapGesture) {
        print(sender.id)
    }
}

extension WidgetViewController: WidgetPresenterToViewProtocol {
    func showErrorInternetConnection() {
        showErrorView(message: "Looks like there is no internet connection")
    }
    
    func setCharacterData(character: Character, characterView: UIView, characterLabel: UILabel, imageView: UIImageView) {
        let tap = MyTapGesture(target: self, action: #selector(self.handleTap(_:)))
        tap.id = character.id!
        characterView.addGestureRecognizer(tap)
        characterLabel.text = character.name
        if let imageURL = getImageUrl(character: character) {
            Alamofire.request(imageURL).responseImage { [weak self] (response) in
                if response.error == nil, let image = response.value {
                    imageView.image = image
                }
            }
        }
    }
    
    func showCharacters() {
        if let presenter = presenter, presenter.getCharacters().count > 0 {
            let count = presenter.getCharacters().count
            
            setCharacterData(character: presenter.getCharacters()[0],
                             characterView: firstCharacterView,
                             characterLabel: firstCharacterLabel,
                             imageView: firstImageView)
            
            if count > 1 {
                setCharacterData(character: presenter.getCharacters()[1],
                                    characterView: secondCharacterView,
                                    characterLabel: secondCharacterLabel,
                                    imageView: secondImageView)
            } else {
                secondCharacterView.isHidden = true
            }
            
            if count > 2 {
                setCharacterData(character: presenter.getCharacters()[2],
                                    characterView: thirdCharacterView,
                                    characterLabel: thirdCharacterLabel,
                                    imageView: thirdImageView)
            } else {
                thirdCharacterView.isHidden = true
            }
            
            hideErrorView()
        } else {
            showErrorView(message: "Looks like there is no characters to list.")
        }
    }
    
    private func getImageUrl(character: Character) -> String? {
        guard let thumbnail = character.thumbnail,
            let path = thumbnail.path,
            let thumbnailExtension = thumbnail.thumbnailExtension else {
            return nil
        }
        
        return "\(path).\(thumbnailExtension)"
    }
    
    func showError() {
        showErrorView(message: "An error has occurred, please try again.")
    }
}

class MyTapGesture: UITapGestureRecognizer {
    var id = 0
}

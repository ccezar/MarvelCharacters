//
//  HomeViewController.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 07/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class HomeViewController: UIViewController {
    
    @IBOutlet weak var collectionView: UICollectionView!

    var presenter: HomeViewToPresenterProtocol?

    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.startFetchingCharacters()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func showCharacters(characters: [Character]?) {
        guard let elements = characters else {
            return
        }
        
        self.characters.removeAll()
        self.characters.append(contentsOf: elements)
        collectionView.reloadData()
    }
    
    func appendCharacters(characters: [Character]?) {
        guard let elements = characters else {
            return
        }
        
        self.characters.append(contentsOf: elements)
        collectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "An error has occurred, please try again.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showErrorAppend() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "An error has occurred in pagination, please try again.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
    
    func showErrorRefresh() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "An error has occurred to refresh data, please try again.",
                                      preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return characters.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.nameLabel.text = characters[indexPath.row].name

        if let thumbnail = characters[indexPath.row].thumbnail,
            let path = thumbnail.path,
            let thumbnailExtension = thumbnail.thumbnailExtension {
            let imageURL = "\(path).\(thumbnailExtension)"
            Alamofire.request(imageURL).responseData { (response) in
                if response.error != nil, let data = response.data {
                    cell.thumbImageView.image = UIImage(data: data)
                }
            }
        }

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 150, height: 180)
    }
}


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

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter?.startFetchingCharacters()
        
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.collectionViewLayout.invalidateLayout()
    }
}

extension HomeViewController: HomePresenterToViewProtocol {
    func showCharacters() {
        collectionView.reloadData()
    }
    
    func appendCharacters(characters: [Character]?) {
        collectionView.reloadData()
    }
    
    func showError() {
        let alert = UIAlertController(title: "Ops!",
                                      message: "An error has occurred, please try again.",
                                      preferredStyle: .alert)

        alert.addAction(
            UIAlertAction(title: "Ok", style: .default) { [weak self] (UIAlertAction) in
                self?.presenter?.startFetchingCharacters()
            }
        )
        
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

        alert.addAction(
            UIAlertAction(title: "Ok", style: .default) { [weak self] (UIAlertAction) in
                self?.presenter?.startFetchingCharacters()
            }
        )
        
        self.present(alert, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.characters.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CharacterCollectionViewCell", for: indexPath) as! CharacterCollectionViewCell
        cell.nameLabel.text = presenter?.characters[indexPath.row].name

        cell.thumbImageView.image = UIImage(named: "no-image-icon")
        
        // TODO: Remove reference of Alamofire from View layer. Is it correct to move this logic to Presenter and Interactor respectively?
        if let thumbnail = presenter?.characters[indexPath.row].thumbnail,
            let path = thumbnail.path,
            let thumbnailExtension = thumbnail.thumbnailExtension {
            let imageURL = "\(path).\(thumbnailExtension)"
            Alamofire.request(imageURL).responseData { [weak self] (response) in
                if response.error == nil, let data = response.data {
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
        return CGSize(width: 200, height: 230)
    }
}


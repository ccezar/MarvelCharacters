//
//  CharacterDetailsViewController.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire

class CharacterDetailsViewController: UIViewController {
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var comicsView: UIView!
    @IBOutlet weak var seriesView: UIView!
    @IBOutlet weak var comicsCollectionView: UICollectionView!
    @IBOutlet weak var seriesCollectionView: UICollectionView!

    var presenter: CharacterDetailsViewToPresenterProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = presenter?.getName()
        
        comicsCollectionView.delegate = self
        comicsCollectionView.dataSource = self
        seriesCollectionView.delegate = self
        seriesCollectionView.dataSource = self
        
        comicsView.isHidden = true
        seriesView.isHidden = true
        
        configureFavoriteButton()
        loadData()
    }
    
    func configureFavoriteButton() {
        let imageName = presenter?.isShowingFavorite() ?? false ? "liked" : "like"
        
        let favoriteButton = UIBarButtonItem(image: UIImage(named: imageName), style: .plain, target: self, action: #selector(didTapFavoriteButton(_:)))
        self.navigationItem.rightBarButtonItem  = favoriteButton
    }
    
    @objc private func didTapFavoriteButton(_ sender: Any) {
        updateFavoriteStatus()
    }
    
    private func updateFavoriteStatus() {
        if self.navigationItem.rightBarButtonItem?.image == UIImage(named: "like") {
            if presenter?.isShowingFavorite() ?? false, let favorite = presenter?.getFavorite() {
                presenter?.addFavorite(favorite: favorite)
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "liked")
            } else if let character = presenter?.getCharacter() {
                presenter?.addFavorite(character: character)
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "liked")
            }
        } else {
            if presenter?.isShowingFavorite() ?? false, let favorite = presenter?.getFavorite() {
                presenter?.removeFavorite(id: favorite.id)
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "like")
            } else if let id = presenter?.getCharacter()?.id {
                presenter?.removeFavorite(id: id)
                self.navigationItem.rightBarButtonItem?.image = UIImage(named: "like")
            }
        }
    }
    
    func loadData() {
        if let imageURL = presenter?.getImageURL(), imageURL != "" {
            Alamofire.request(imageURL).responseImage { [weak self] (response) in
                if response.error == nil, let image = response.value {
                    self?.thumbImageView.image = image
                }
            }
        }
        
        if let description = presenter?.getDescription(), description != "" {
            descriptionLabel.isHidden = false
            descriptionLabel.text = description
        } else {
            descriptionLabel.isHidden = true
        }
        
        if presenter?.isShowingFavorite() ?? false {
            guard let presenter = presenter else {
                return
            }

            if presenter.getComics().count > 0 {
                comicsView.isHidden = false
                comicsCollectionView.reloadData()
            } else if let characterId = presenter.getFavorite()?.id {
                presenter.startFetchingComics(characterId: characterId)
            }
            
            if presenter.getSeries().count > 0 {
                seriesView.isHidden = false
                seriesCollectionView.reloadData()
            } else if let characterId = presenter.getFavorite()?.id {
                presenter.startFetchingSeries(characterId: characterId)
            }
        } else {
            guard let characterId = presenter?.getCharacter()?.id else {
                return
            }
            
            presenter?.startFetchingComics(characterId: characterId)
            presenter?.startFetchingSeries(characterId: characterId)
        }
    }
}

extension CharacterDetailsViewController: CharacterDetailsPresenterToViewProtocol {
    func showComics() {
        if presenter?.getComics().count ?? 0 > 0 {
            comicsView.isHidden = false
            comicsCollectionView.reloadData()
        } else {
            comicsView.isHidden = true
        }
    }
    
    func showSeries() {
        if presenter?.getSeries().count ?? 0 > 0 {
            seriesView.isHidden = false
            seriesCollectionView.reloadData()
        } else {
            seriesView.isHidden = true
        }
    }
}

//MARK: UICollectionView
extension CharacterDetailsViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == comicsCollectionView {
            return presenter?.getComics().count ?? 0
        }
        
        if collectionView == seriesCollectionView {
            return presenter?.getSeries().count ?? 0
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == comicsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCollectionViewCell", for: indexPath) as! ProductionCollectionViewCell

            if let comic = presenter?.getComics()[indexPath.row] {
                cell.item = comic
                
                Alamofire.request(comic.imageURL).responseImage { [weak self] (response) in
                    if response.error == nil, let image = response.value {
                        cell.thumbImageView.image = image
                    }
                }
            }
            
            return cell
        }
        
        if collectionView == seriesCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductionCollectionViewCell", for: indexPath) as! ProductionCollectionViewCell

            if let serie = presenter?.getSeries()[indexPath.row] {
                cell.item = serie
                
                Alamofire.request(serie.imageURL).responseImage { [weak self] (response) in
                    if response.error == nil, let image = response.value {
                        cell.thumbImageView.image = image
                    }
                }
            }
            
            return cell
        }

        return UICollectionViewCell()
    }
}

//MARK: UICollectionViewDelegateFlowLayout
extension CharacterDetailsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: 230)
    }
}

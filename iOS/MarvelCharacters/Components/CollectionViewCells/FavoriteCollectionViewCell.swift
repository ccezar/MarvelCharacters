//
//  FavoriteCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

protocol FavoriteCollectionViewCellProtocol: class {
    func removeFavorite(id: Int)
}

class FavoriteCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: FavoriteCollectionViewCellProtocol?
    
    var favorite: FavoriteCharacter? {
        didSet {
            if let favorite = favorite {
                nameLabel.text = favorite.name
                thumbImageView.image = nil
                if favorite.imageURL != "" {
                    Alamofire.request(favorite.imageURL).responseImage { [weak self] (response) in
                        if response.error == nil, let image = response.value {
                            self?.thumbImageView.image = image
                        }
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.cardView.layer.shadowRadius = 7
        self.cardView.layer.shadowOpacity = 0.6
        self.cardView.layer.shadowColor = UIColor.gray.cgColor
        self.cardView.layer.cornerRadius = 10
    }
    
    @IBAction func didTapFavoriteButton(_ sender: Any) {
        if let favorite = favorite {
            delegate?.removeFavorite(id: favorite.id)
        }
    }
}

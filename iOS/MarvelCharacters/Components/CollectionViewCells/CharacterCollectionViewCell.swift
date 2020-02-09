//
//  CharacterCollectionViewCell.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 08/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit


protocol CharacterCollectionViewCellProtocol: class {
    func updateFavoriteStatus(character: Character)
}

class CharacterCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var favoriteButton: UIButton!
    
    var delegate: CharacterCollectionViewCellProtocol?
    
    var character: Character? {
        didSet {
            if let character = character {
                nameLabel.text = character.name
                thumbImageView.image = UIImage(named: "no-image-icon")
                favoriteButton.setImage(UIImage(named: character.isFavorite() ? "liked" : "like"), for: .normal)
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
        if let character = character {
            if character.isFavorite() {
                character.unsetFavorite()
                favoriteButton.setImage(UIImage(named: "like"), for: .normal)
            } else {
                character.setFavorite()
                favoriteButton.setImage(UIImage(named: "liked"), for: .normal)
            }
            
            delegate?.updateFavoriteStatus(character: character)
        }
    }
    
    
    
}

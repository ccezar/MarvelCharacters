//
//  ProductionCllectionViewCell..swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 10/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit

class ProductionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var thumbImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    var item: FavoriteProduction? {
        didSet {
            if let item = item {
                nameLabel.text = item.name
                thumbImageView.image = nil
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
}

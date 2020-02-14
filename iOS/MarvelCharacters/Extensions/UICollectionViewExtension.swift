//
//  UICollectionViewExtension.swift
//  MarvelCharacters
//
//  Created by Caio Cezar Lopes dos Santos on 14/02/20.
//  Copyright © 2020 MyExperiments. All rights reserved.
//

import UIKit

extension UICollectionView {
    func dequeue<T: UICollectionViewCell>(indexPath: IndexPath) -> T? {
        if let cell = self.dequeueReusableCell(withReuseIdentifier: T.named, for: indexPath) as? T {
            print(cell)
            
            return cell
        }
        
        return nil
    }
}

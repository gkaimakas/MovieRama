//
//  UICollectionView.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import UIKit

extension UICollectionView {
    public func register<T: UICollectionViewCell>(_ type: T.Type) {
        self.register(T.nib,
                      forCellWithReuseIdentifier: T.identifier)
    }
    
    public func dequeueReusableCell<T: UICollectionViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withReuseIdentifier: T.identifier,
                                   for: indexPath) as! T
    }
}

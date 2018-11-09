//
//  UITableViewCell.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import UIKit

extension UITableViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
    
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: Bundle(for: self))
    }
}

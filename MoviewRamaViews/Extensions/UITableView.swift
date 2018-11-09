//
//  UITableView.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import UIKit

extension UITableView {
    public func register<T: UITableViewCell>(_ type: T.Type) {
        self.register(T.nib,
                      forCellReuseIdentifier: T.identifier)
    }
    
    public func dequeueReusableCell<T: UITableViewCell>(_ type: T.Type, indexPath: IndexPath) -> T {
        return dequeueReusableCell(withIdentifier: T.identifier, for: indexPath) as! T
    }
}

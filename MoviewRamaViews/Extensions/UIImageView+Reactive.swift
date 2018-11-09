//
//  UIImageView+Reactive.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation
import Imaginary
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

extension Reactive where Base: UIImageView {
    public var urlImage: BindingTarget<(URL, UIImage?)> {
        return makeBindingTarget({ (view, data) in
            view.setImage(url: data.0,
                          placeholder: data.1)
            
        })
    }
}

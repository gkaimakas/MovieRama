//
//  UILabel+Reactive.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

extension Reactive where Base: UILabel {
    public var font: BindingTarget<UIFont> {
        return makeBindingTarget({ (label, font) in
            label.font = font
        })
    }
}

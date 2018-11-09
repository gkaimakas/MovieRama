//
//  MovieViewController+Row.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import ReactiveSwift
import Result
import Foundation

extension MovieViewController {
    enum Row {
        case title(Property<String?>)
        case label(String?)
        case content(Property<String?>)
        case padding(CGFloat)
        
        var id: String {
            switch self {
            case .title(let property):
                return "title-\(property.value ?? "")"
            case .label(let value):
                return "label-\(value ?? "")"
            case .content(let property):
                return "content-\(property.value ?? "")"
            case .padding(let height):
                return "padding-\(height)"
            }
        }
    }
}

extension MovieViewController.Row: Equatable {
    static func ==(lhs: MovieViewController.Row, rhs: MovieViewController.Row) -> Bool {
        return lhs.id == rhs.id
    }
}

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
        case subLabel(String?)
        case content(Property<String?>)
        case padding(CGFloat)
        case favorite
        
        var id: String {
            switch self {
            case .title(let property):
                return "title-\(property.value ?? "")"
            case .label(let value):
                return "label-\(value ?? "")"
            case .subLabel(let value):
                return "subLabel-\(value ?? "")"
            case .content(let property):
                return "content-\(property.value ?? "")"
            case .padding(let height):
                return "padding-\(height)"
            case .favorite:
                return "favorite"
            }
        }
    }
}

extension MovieViewController.Row: Equatable {
    static func ==(lhs: MovieViewController.Row, rhs: MovieViewController.Row) -> Bool {
        return lhs.id == rhs.id
    }
}

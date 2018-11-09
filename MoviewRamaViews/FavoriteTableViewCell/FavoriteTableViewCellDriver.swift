//
//  FavoriteTableViewCellDriver.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 10/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaViewModels
import ReactiveCocoa
import ReactiveSwift
import Result
import UIKit

public protocol FavoriteTableViewCellDriver: class {
    var voteAverage: Property<Double> { get }
    var releasedAt: Property<Date?> { get }
    var isFavorite: Property<Bool> { get }
    var toggleFavorite: Action<Void, Bool, ProviderError> { get }
}

extension MovieViewModel: FavoriteTableViewCellDriver { }

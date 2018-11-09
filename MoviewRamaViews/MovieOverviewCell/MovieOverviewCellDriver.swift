//
//  MovieOverviewCellDriver.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaViewModels
import ReactiveCocoa
import ReactiveSwift
import Result

public protocol MovieOverviewCellDriver: class {
    var title: Property<String?> { get }
    var voteAverage: Property<Double> { get }
    var releasedAt: Property<Date?> { get }
    var isFavorite: Property<Bool> { get }
    var posterURL: Property<URL?> { get }
    var backdropURL: Property<URL?> { get }
    var toggleFavorite: Action<Void, Bool, ProviderError> { get }
}

extension MovieViewModel: MovieOverviewCellDriver { }

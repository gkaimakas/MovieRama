//
//  SimilarMovieCellDriver.swift
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

public protocol SimilarMovieCellDriver: class {
    var posterURL: Property<URL?> { get }
}

extension MovieViewModel: SimilarMovieCellDriver { }

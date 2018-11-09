//
//  SimilarMoviesTableViewCell+Row.swift
//  MoviewRamaViews
//
//  Created by George Kaimakas on 10/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaViewModels

extension SimilarMoviesTableViewCell {
    enum Row {
        case movie(MovieViewModel)
        case isLoading
    }
}

extension SimilarMoviesTableViewCell.Row: Equatable {
    static func ==(lhs: SimilarMoviesTableViewCell.Row, rhs: SimilarMoviesTableViewCell.Row) -> Bool {
        switch (lhs, rhs) {
        case (.isLoading, .isLoading):
            return true
        case (.isLoading, .movie):
            return false
        case (.movie, isLoading):
            return false
        case (.movie(let a), .movie(let b)):
            return a == b
        }
    }
}

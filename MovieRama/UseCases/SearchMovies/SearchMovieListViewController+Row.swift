//
//  SearchMovieListViewController+Row.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaViewModels

extension SearchMovieListViewController {
    enum Row {
        case movie(MovieViewModel)
        case isLoading
    }
}

extension SearchMovieListViewController.Row: Equatable {
    static func ==(lhs: SearchMovieListViewController.Row, rhs: SearchMovieListViewController.Row) -> Bool {
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

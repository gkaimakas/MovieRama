//
//  PopularMovieListViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class PopularMovieListViewModel {
    let _movies: MutableProperty<[MovieViewModel]>
    let _currentPage: MutableProperty<Int>
    
    public let movies: Property<[MovieViewModel]>
    
    public let fetchMovies: Action<Void, [MovieViewModel], ProviderError>
    public let forceFetchMovies: Action<Void, [MovieViewModel], ProviderError>
    
    public init(movieProvider: MovieProviderProtocol) {
        _movies = MutableProperty([])
        movies = Property(_movies)
        
        _currentPage = MutableProperty(1)
        
        fetchMovies = Action(state: _currentPage) { (page, _) in
            return movieProvider
                .fetchPopularMovieList(page: page)
                .map { $0.results }
                .map { list -> [MovieViewModel] in
                    return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
            }
        }
        
        forceFetchMovies = Action { _ in
            return movieProvider
                .fetchPopularMovieList(page: 1)
                .map { $0.results }
                .map { list -> [MovieViewModel] in
                    return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                }
        }
        
        _movies <~ fetchMovies
            .values
            .map { [unowned self] result -> [MovieViewModel] in
                return self._movies.value + result
            }
        
        _currentPage <~ fetchMovies
            .values
            .map { [unowned self] _ in
                return self._currentPage.value + 1
            }
        
        _movies <~ forceFetchMovies
            .values
        
        _currentPage <~ forceFetchMovies
            .values
            .map { _ in 1 }
    }
}

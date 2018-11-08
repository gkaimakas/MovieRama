//
//  SimilarMovieListViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class SimilarMovieListViewModel {
    let _movies: MutableProperty<[MovieViewModel]>
    let _currentPage: MutableProperty<Int>
    
    public let movies: Property<[MovieViewModel]>
    
    public let fetchSimilarMovies: Action<Void, [MovieViewModel], ProviderError>
    public let forceFetchSimilarMovies: Action<Void, [MovieViewModel], ProviderError>
    
    public init(movieId: Int,
                movieProvider: MovieProviderProtocol) {
        weak var weakSelf: SimilarMovieListViewModel!
        
        _movies = MutableProperty([])
        movies = Property(_movies)
        
        _currentPage = MutableProperty(1)
        fetchSimilarMovies = Action { _ in
            return weakSelf
                ._currentPage
                .producer
                .take(first: 1)
                .promoteError(ProviderError.self)
                .flatMap(.latest) { page -> SignalProducer<Page<MovieOverview>, ProviderError> in
                    return movieProvider
                        .fetchSimilarMovies(movieId: movieId, page: page)
                }
                .map { $0.results }
                .map { list -> [MovieViewModel] in
                    return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                }
        }
        
        forceFetchSimilarMovies = Action { _ in
            return movieProvider
                .fetchSimilarMovies(movieId: movieId, page: 1)
                .map { $0.results }
                .map { list -> [MovieViewModel] in
                    return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                }
        }
        
        weakSelf = self
        
        _movies <~ fetchSimilarMovies
            .values
            .map { [unowned self] result -> [MovieViewModel] in
                return self._movies.value + result
            }
        
        _movies <~ forceFetchSimilarMovies
            .values
        
        _currentPage <~ fetchSimilarMovies
            .values
            .map { [unowned self] _ -> Int in
                return self._currentPage.value + 1
            }
        
        _currentPage <~ forceFetchSimilarMovies
            .values
            .map { _ in 1 }
    }
}

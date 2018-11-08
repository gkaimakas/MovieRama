//
//  MovieProviderProtocol.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import ReactiveSwift
import Result

public protocol MovieProviderProtocol {
    func fetchPopularMovieList(page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError>
    func search(query: String, page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError>
    func fetchMovie(id: Int) -> SignalProducer<Movie, ProviderError>
    func fetchReviews(movieId: Int, page: Int) -> SignalProducer<Page<Review>, ProviderError>
    func fetchSimilarMovies(movieId: Int, page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError>
    func addToFavorites(movieId: Int) -> SignalProducer<Int, ProviderError>
    func removedFromFavorites(movieId: Int) -> SignalProducer<Int, ProviderError>
}

public class MovieProvider: MovieProviderProtocol {
    
    let localProvider: MovieLocalProviderProtocol
    let remoteProvider: MovieRemoteProviderProtocol
    
    public init(localProvider: MovieLocalProviderProtocol,
                remoteProvider: MovieRemoteProviderProtocol) {
        
        self.localProvider = localProvider
        self.remoteProvider = remoteProvider
    }
    
    public func fetchPopularMovieList(page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError> {
        return remoteProvider
            .fetchPopularMovieList(page: page)
            .mapError { ProviderError.remote($0) }
            .zip(with: localProvider.fetchFavoriteList()
                .mapError { ProviderError.local($0) }
            )
            .map { (page, favorites) -> Page<MovieOverview> in
                return page.mapResults(transform: { (value) -> MovieOverview in
                    value.with(favorite: favorites.contains(value.id) )
                })
        }
    }
    
    public func search(query: String, page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError> {
        return remoteProvider
            .search(query: query, page: page)
            .mapError { ProviderError.remote($0) }
            .zip(with: localProvider.fetchFavoriteList()
                .mapError { ProviderError.local($0) }
            )
            .map { (page, favorites) -> Page<MovieOverview> in
                return page.mapResults(transform: { (value) -> MovieOverview in
                    value.with(favorite: favorites.contains(value.id) )
                })
        }
    }
    
    public func fetchMovie(id: Int) -> SignalProducer<Movie, ProviderError> {
        return remoteProvider
            .fetchMovie(id: id)
            .mapError { ProviderError.remote($0) }
            .zip(with: localProvider.fetchFavoriteList()
                .mapError { ProviderError.local($0) }
            )
            .map { (movie, favorites) -> Movie in
                return movie.with(favorite: favorites.contains(movie.id))
            }
    }
    
    public func fetchReviews(movieId: Int, page: Int) -> SignalProducer<Page<Review>, ProviderError> {
        return remoteProvider
            .fetchReviews(movieId: movieId, page: page)
            .mapError { ProviderError.remote($0) }
    }
    
    public func fetchSimilarMovies(movieId: Int, page: Int) -> SignalProducer<Page<MovieOverview>, ProviderError> {
        return remoteProvider
            .fetchSimilarMovies(movieId: movieId, page: page)
            .mapError { ProviderError.remote($0) }
            .zip(with: localProvider.fetchFavoriteList()
                .mapError { ProviderError.local($0) }
            )
            .map { (page, favorites) -> Page<MovieOverview> in
                return page.mapResults(transform: { (value) -> MovieOverview in
                    value.with(favorite: favorites.contains(value.id) )
                })
        }
    }
    
    public func addToFavorites(movieId: Int) -> SignalProducer<Int, ProviderError> {
        return localProvider
            .addToFavorites(movieId: movieId)
            .mapError { ProviderError.local($0) }
    }
    
    public func removedFromFavorites(movieId: Int) -> SignalProducer<Int, ProviderError> {
        return localProvider
            .removeFromFavorites(movieId: movieId)
            .mapError { ProviderError.local($0) }
    }
}

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

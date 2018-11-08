//
//  MovieRemoteProviderProtocol.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import ReactiveSwift
import Result

public protocol MovieRemoteProviderProtocol {
    func fetchPopularMovieList(page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError>
    func search(query: String, page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError>
    func fetchMovie(id: Int) -> SignalProducer<Movie, RemoteProviderError>
    func fetchReviews(movieId: Int, page: Int) -> SignalProducer<Page<Review>, RemoteProviderError>
    func fetchSimilarMovies(movieId: Int, page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError>
}

//
//  MovieRemoteProvider.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Alamofire
import MovieRamaCommon
import ReactiveSwift
import Result

public class MovieRemoteProvider: RemoteProvider, MovieRemoteProviderProtocol {
    
    public func fetchPopularMovieList(page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError> {
        return sessionManager
            .request(MovieRouter.fetchPopularMovieList(page: page))
            .validate()
            .reactive
            .responseJSON()
            .promoteRemoteProviderError()
            .decode(using: PagedMovieOverviewDecoder(movieOverviewDecoder: MovieOverviewDecoder()))
    }
    
    public func search(query: String, page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError> {
        return sessionManager
            .request(MovieRouter.search(query: query, page: page))
            .validate()
            .reactive
            .responseJSON()
            .promoteRemoteProviderError()
            .decode(using: PagedMovieOverviewDecoder(movieOverviewDecoder: MovieOverviewDecoder()))
    }
    
    public func fetchMovie(id: Int) -> SignalProducer<Movie, RemoteProviderError> {
        return sessionManager
            .request(MovieRouter.fetchMovie(id: id))
            .validate()
            .reactive
            .responseJSON()
            .promoteRemoteProviderError()
            .decode(using: MovieDecoder())
    }
    
    public func fetchReviews(movieId: Int, page: Int) -> SignalProducer<Page<Review>, RemoteProviderError> {
        return sessionManager
            .request(MovieRouter.fetchReviews(movieId: movieId, page: page))
            .validate()
            .reactive
            .responseJSON()
            .promoteRemoteProviderError()
            .decode(using: PagedReviewDecoder())
    }
    
    public func fetchSimilarMovies(movieId: Int, page: Int) -> SignalProducer<Page<MovieOverview>, RemoteProviderError> {
        return sessionManager
            .request(MovieRouter.fetchSimilarMovies(movieId: movieId, page: page))
            .validate()
            .reactive
            .responseJSON()
            .promoteRemoteProviderError()
            .decode(using: PagedMovieOverviewDecoder(movieOverviewDecoder: MovieOverviewDecoder()))
    }
}

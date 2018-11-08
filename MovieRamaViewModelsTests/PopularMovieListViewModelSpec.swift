//
//  PopularMovieListViewModelSpec.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result
import Quick
import Nimble
@testable import MovieRamaViewModels

class PopularMovieListViewModelSpec: QuickSpec {
    override func spec() {
        let viewModel = PopularMovieListViewModel(
            movieProvider: MovieProvider(localProvider: MovieLocalProvider(),
                                         remoteProvider: MovieRemoteProvider()))
        
        describe("PopularMovieListViewModel") {
            it("should fetch a list of movies") {
                var results: [MovieViewModel] = []
                
                viewModel
                    .movies
                    .producer
                    .on(value: { list in
                        results = list
                    })
                    .start()
                
                viewModel
                    .fetchMovies
                    .apply()
                    .delay(1, on: QueueScheduler.main)
                    .then(viewModel
                        .fetchMovies
                        .apply()
                    )
                    .start()
                
                expect(results.count).toEventually(equal(40), timeout: 10)
            }
            
            it("should refresh the list of movies") {
                var results: [MovieViewModel] = []
                
                viewModel
                    .movies
                    .producer
                    .on(value: { list in
                        results = list
                    })
                    .start()
                
                viewModel
                    .fetchMovies
                    .apply()
                    .delay(1, on: QueueScheduler.main)
                    .then(viewModel
                        .fetchMovies
                        .apply()
                        .delay(1, on: QueueScheduler.main)
                        .then(viewModel
                            .forceFetchMovies
                            .apply()
                        )
                    )
                    .start()
                
                expect(results.count).toEventually(equal(20), timeout: 10)
            }
        }
    }
}


//
//  SearchMovieListViewModelSpec.swift
//  MovieRamaViewModelsTests
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

class SearchMovieListViewModelSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        let viewModel = SearchMovieListViewModel(movieProvider: MovieProvider(localProvider: MovieLocalProvider(),
                                                                              remoteProvider: MovieRemoteProvider()))
        
        describe("SearchMovieListViewModel") {
            it("should start with a list of popular movies") {
                var result: [MovieViewModel] = []
                
                viewModel
                    .movies
                    .producer
                    .on(value: { result = $0 })
                    .start()
                
                expect(result.count).toEventually(beGreaterThan(0), timeout: 10)
            }
            
            it("should fetch the results of a query") {
                var result: [MovieViewModel] = []
                
                viewModel
                    .movies
                    .signal
                    .observeValues({ result = $0 })
                
                viewModel.query.value = "avengers"
                expect(result.count).toEventually(beGreaterThan(0), timeout: 10)
            }
            
            it("should keep fetching more results of a query") {
                var result: [MovieViewModel] = []
                
                viewModel
                    .movies
                    .signal
                    .observeValues({ result = $0 })
                
                viewModel.query.value = "avengers"
                viewModel
                    .fetchMovies
                    .apply()
                    .start()
                
                expect(result.count).toEventually(equal(40), timeout: 10)
                
            }
        }
    }
}

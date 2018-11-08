//
//  MovieProviderSpec.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Alamofire
import MovieRamaCommon
import ReactiveSwift
import Result
import Quick
import Nimble
@testable import MovieRamaModels

class MovieRemoteProviderSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("MovieRemoteProvider") {
            let provider = MovieRemoteProvider(sessionManager: SessionManager.default)
            
            describe("fetchPopularMovieList(page:)") {
                it("should fetch a page of popular movies") {
                    var result: Page<MovieOverview>? = nil
                    
                    provider
                        .fetchPopularMovieList(page: 1)
                        .on(value: { value in
                            result = value
                        })
                        .start()
                    
                    expect(result).toEventuallyNot(beNil(), timeout: 10)
                }
            }
            
            describe("search(query:, page:)") {
                it("should fetch the results of a query") {
                    
                    var result: Page<MovieOverview>? = nil
                    provider
                        .search(query: "avengers", page: 1)
                        .on(value: { value in
                            result = value
                        })
                        .start()
                    
                    expect(result).toEventuallyNot(beNil(), timeout: 10)
                    
                }
            }
            
            describe("fetchMovie(id:)") {
                it("should fetch the specified movie") {
                    
                    var result: Movie? = nil
                    provider
                        .fetchMovie(id: 297265)
                        .on(value: { value in
                            result = value
                        })
                        .start()
                    
                    expect(result).toEventuallyNot(beNil(), timeout: 10)
                }
            }
        }
    }
}

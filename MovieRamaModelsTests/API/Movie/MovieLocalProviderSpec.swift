//
//  MovieLocalProviderSpec.swift
//  MovieRamaModelsTests
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import ReactiveSwift
import Result
import Quick
import Nimble
@testable import MovieRamaModels

class MovieLocalProviderSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        let provider = MovieLocalProvider()
        
        describe("MovieLocalProvider") {
            describe("fetchFavoriteList") {
                it("should return an array with the favorite movie ids") {
                    var result: [Int]? = nil
                    
                    provider
                        .fetchFavoriteList()
                        .on(value: { result = $0 })
                        .start()
                    
                    expect(result).toEventuallyNot(beNil())
                }
            }
            
            describe("addToFavorites(movieId:)") {
                it("should add a movie id to the favorites") {
                    
                    let movieId = Int(arc4random_uniform(10_000))
                    var isInFavorites = false
                    
                    provider
                        .addToFavorites(movieId: movieId)
                        .flatMap(.latest) { _ in
                            return provider.fetchFavoriteList()
                        }
                        .on(value: { list in
                            isInFavorites = list.contains(movieId)
                        })
                        .start()
                    
                    expect(isInFavorites).toEventually(equal(true))
                }
            }
            
            describe("removedFromFavorites(movieId:)") {
                it("should remove a movie id from favorites") {
                
                    let movieId = Int(arc4random_uniform(10_000))
                    var isInFavorites = true
                    
                    provider
                        .addToFavorites(movieId: movieId)
                        .flatMap(.latest) { _ in
                            return provider.removeFromFavorites(movieId: movieId)
                        }
                        .flatMap(.latest) { _ in
                            return provider.fetchFavoriteList()
                        }
                        .on(value: { list in
                            isInFavorites = list.contains(movieId)
                        })
                        .start()
                    
                    expect(isInFavorites).toEventually(equal(false))

                }
            }
        }
    }
}

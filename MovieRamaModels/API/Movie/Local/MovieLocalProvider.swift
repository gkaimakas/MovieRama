//
//  MovieLocalProvider.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import ReactiveSwift
import Result
import SwiftyUserDefaults

public class MovieLocalProvider: MovieLocalProviderProtocol {
    let lock = NSLock()
    
    public init() {
        UserDefaults
            .standard
            .register(defaults: [
                DefaultsKeys.favoriteMovieIds._key: []
                ])
    }
    
    public func fetchFavoriteList() -> SignalProducer<[Int], LocalProviderError> {
        return SignalProducer<[Int], LocalProviderError> { [weak self] observer, lifetime in
            guard let self = self else {
                return observer.sendCompleted()
            }
            
            self.lock.lock()
            observer.send(value: Defaults[.favoriteMovieIds])
            self.lock.unlock()
            observer.sendCompleted()
        }
    }
    
    public func addToFavorites(movieId: Int) -> SignalProducer<Int, LocalProviderError> {
        return SignalProducer<Int, LocalProviderError> { [weak self] observer, lifetime in
            guard let self = self else {
                return observer.sendCompleted()
            }
            
            self.lock.lock()
            var currentFavorites = Defaults[.favoriteMovieIds]
            if currentFavorites.contains(movieId) == false {
                currentFavorites.append(movieId)
            }
            Defaults[.favoriteMovieIds] = currentFavorites
            self.lock.unlock()
            
            observer.send(value: movieId)
            observer.sendCompleted()
        }
    }
    
    public func removeFromFavorites(movieId: Int) -> SignalProducer<Int, LocalProviderError> {
        return SignalProducer<Int, LocalProviderError> { [weak self] observer, lifetime in
            guard let self = self else {
                return observer.sendCompleted()
            }
            
            self.lock.lock()
            Defaults[.favoriteMovieIds] = Defaults[.favoriteMovieIds].filter { $0 != movieId }
            self.lock.unlock()
            
            observer.send(value: movieId)
            observer.sendCompleted()
        }
    }
}

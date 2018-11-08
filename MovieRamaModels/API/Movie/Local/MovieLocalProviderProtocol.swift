//
//  MovieLocalProviderProtocol.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import ReactiveSwift
import Result

public protocol MovieLocalProviderProtocol {
    func fetchFavoriteList() -> SignalProducer<[Int], LocalProviderError>
    func addToFavorites(movieId: Int) -> SignalProducer<Int, LocalProviderError>
    func removeFromFavorites(movieId: Int) -> SignalProducer<Int, LocalProviderError>
}

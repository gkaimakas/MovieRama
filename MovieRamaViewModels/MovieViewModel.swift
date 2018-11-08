//
//  MovieViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class MovieViewModel {
    let _infoState: MutableProperty<InfoState>
    
    public let fetchInfo: Action<Void, Void, ProviderError>
    public let fetchReviews: Action<Void, Void, ProviderError>
    public let fetchSimilarMovies: Action<Void, Void, ProviderError>
    public let favorite: Action<Bool, Bool, ProviderError>
    
    public init(raw: MovieOverview,
                movieProvider: MovieProviderProtocol) {
        
        _infoState = MutableProperty(.overview)
        
        let isFetchInfoEnabled = _infoState.map { $0 == .overview }
        fetchInfo = Action(enabledIf: isFetchInfoEnabled) { _ in
            return SignalProducer.empty
        }
        
        fetchReviews = Action { _ in
            return SignalProducer.empty
        }
        
        fetchSimilarMovies = Action { _ in
            return SignalProducer.empty
        }
        
        favorite = Action { value in
            return SignalProducer.empty
        }
        
        _infoState <~ fetchInfo
            .values
            .map { _ in return .detail }
        
    }
}

extension MovieViewModel {
    public enum InfoState {
        case overview
        case detail
    }
}

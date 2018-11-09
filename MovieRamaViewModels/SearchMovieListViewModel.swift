//
//  SearchMovieListViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class SearchMovieListViewModel {
    let _currentPage: MutableProperty<Int>
    let _movies: MutableProperty<[MovieViewModel]>
    let (_isExecutingSingal, _isExecutingObserver) = Signal<Bool, NoError>.pipe()
    let (_initialSearchErrorSignal, _initialSearchErrorObserver) = Signal<ProviderError, NoError>.pipe()
    
    public let query: MutableProperty<String?>
    public let movies: Property<[MovieViewModel]>
    public let isExecutingInitialSearch: Property<Bool>
    public let initialSearchErrors: Signal<ProviderError, NoError>
    
    public let fetchMovies: Action<Void, [MovieViewModel], ProviderError>
    
    public init(movieProvider: MovieProviderProtocol) {
        _currentPage = MutableProperty(1)
        
        query = MutableProperty(nil)
        
        _movies = MutableProperty([])
        movies = Property(_movies)
        
        isExecutingInitialSearch = Property(initial: false,
                                            then: _isExecutingSingal.skipRepeats())
        
        initialSearchErrors = _initialSearchErrorSignal
        
        let queryInput = query.combineLatest(with: _currentPage)
        fetchMovies = Action(state: queryInput) { (input) in
            guard let query = input.0 else {
                return movieProvider
                    .fetchPopularMovieList(page: input.1)
                    .map { $0.results }
                    .map { list -> [MovieViewModel] in
                        return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                    }
            }
            
            return movieProvider
                .search(query: query, page: input.1)
                .map { $0.results }
                .map { list -> [MovieViewModel] in
                    return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                }
        }
        
        
        _movies <~ fetchMovies
            .values
            .map { [unowned self] result in
                return self._movies.value + result
            }
        
        _currentPage <~ fetchMovies
            .values
            .map { [unowned self] _ in
                return self._currentPage.value + 1
            }
        
        _currentPage <~ query
            .producer
            .map { _ in 2 }
        
        _movies <~ query
            .producer
            .throttle(3, on: QueueScheduler.main)
            .flatMap(.latest) { q -> SignalProducer<[MovieViewModel], NoError> in
                guard let q = q,
                    q.isEmpty == false else {
                    return movieProvider
                        .fetchPopularMovieList(page: 1)
                        .map { $0.results }
                        .map { list -> [MovieViewModel] in
                            return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                        }
                        .flatMapError { err -> SignalProducer<[MovieViewModel], NoError> in
                            self._initialSearchErrorObserver.send(value: err)
                            return SignalProducer.empty
                        }
                }
                
                return movieProvider
                    .search(query: q, page: 1)
                    .map { $0.results }
                    .map { list -> [MovieViewModel] in
                        return list.map { MovieViewModel(raw: $0, movieProvider: movieProvider) }
                    }
                    .flatMapError { err -> SignalProducer<[MovieViewModel], NoError> in
                        self._initialSearchErrorObserver.send(value: err)
                        return SignalProducer.empty
                    }
            }
            .on(started: { [unowned self] in
                    self._isExecutingObserver.send(value: true)
                },
                event: { [unowned self] event in
                    switch event {
                    case .completed:
                        self._isExecutingObserver.send(value: false)
                    case .failed:
                        self._isExecutingObserver.send(value: false)
                    case .interrupted:
                        self._isExecutingObserver.send(value: false)
                    case .value:
                        break
                    }
                },
                interrupted: { [unowned self] in
                    self._isExecutingObserver.send(value: false)
                },
                terminated: { [unowned self] in
                    self._isExecutingObserver.send(value: false)
                },
                disposed: { [unowned self] in
                    self._isExecutingObserver.send(value: false)
                }
            )
    }
}

//
//  ReviewListViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class ReviewListViewModel {
    let _reviews: MutableProperty<[ReviewViewModel]>
    let _currentPage: MutableProperty<Int>
    
    public let reviews: Property<[ReviewViewModel]>
    
    public let fetchReviews: Action<Void, [ReviewViewModel], ProviderError>
    public let forceFetchReviews: Action<Void, [ReviewViewModel], ProviderError>
    
    public init(movieId: Int, movieProvider: MovieProviderProtocol) {
        weak var weakSelf: ReviewListViewModel!
        _reviews = MutableProperty([])
        reviews = Property(_reviews)
        
        _currentPage = MutableProperty(1)
        
        fetchReviews = Action { _ in
            return weakSelf
                ._currentPage
                .producer
                .take(first: 1)
                .promoteError(ProviderError.self)
                .flatMap(.latest) { page -> SignalProducer<Page<Review>, ProviderError> in
                    return movieProvider
                        .fetchReviews(movieId: movieId, page: page)
                }
                .map { $0.results }
                .map { list -> [ReviewViewModel] in
                    return list.map { ReviewViewModel(raw: $0) }
                }
        }
        
        forceFetchReviews = Action { _ in
            return movieProvider
                .fetchReviews(movieId: movieId, page: 1)
                .map { $0.results }
                .map { list -> [ReviewViewModel] in
                    return list.map { ReviewViewModel(raw: $0) }
                }
        }
        
        weakSelf = self
        
        _reviews <~ fetchReviews
            .values
            .map { [unowned self] result in
                return self._reviews.value + result
            }
        
        _currentPage <~ fetchReviews
            .values
            .map { [unowned self] _ -> Int in
                return self._currentPage.value + 1
            }
        
        _reviews <~ forceFetchReviews
            .values
        
        _currentPage <~ forceFetchReviews
            .values
            .map { _ in 1 }
    }
}

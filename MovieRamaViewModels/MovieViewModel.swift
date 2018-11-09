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
    
    let _genres: MutableProperty<[GenreViewModel]>
    let _cast: MutableProperty<[CastMemberViewModel]>
    let _crew: MutableProperty<[CrewMemberViewModel]>
    let _voteAverage: MutableProperty<Double>
    let _isFavorite: MutableProperty<Bool>
    
    public let title: Property<String?>
    public let originalTitle: Property<String?>
    public let overview: Property<String?>
    public let genres: Property<[GenreViewModel]>
    public let posterURL: Property<URL?>
    public let cast: Property<[CastMemberViewModel]>
    public let crew: Property<[CrewMemberViewModel]>
    public let voteAverage: Property<Double>
    public let releasedAt: Property<Date?>
    
    public let isFavorite: Property<Bool>
    
    public let similarMovies: SimilarMovieListViewModel
    public let reviews: ReviewListViewModel
    
    public let fetchInfo: Action<Void, Info, ProviderError>
    public let toggleFavorite: Action<Void, Bool, ProviderError>
    
    public init(raw: MovieOverview,
                movieProvider: MovieProviderProtocol) {
        
        _infoState = MutableProperty(.overview)
        
        title = Property(value: raw.title)
        originalTitle = Property(value: raw.originalTitle)
        overview = Property(value: raw.overview)
        
        _genres = MutableProperty([])
        genres = Property(_genres)
        
        posterURL = Property(value: raw.posterURL)
        
        _cast = MutableProperty([])
        cast = Property(_cast)
        
        _crew = MutableProperty([])
        crew = Property(_crew)
        
        _voteAverage = MutableProperty(raw.voteAverage)
        voteAverage = Property(_voteAverage)
        
        releasedAt = Property(value: raw.releasedAt)
        
        _isFavorite = MutableProperty(raw.isFavorite)
        isFavorite = Property(_isFavorite)
        
        similarMovies = SimilarMovieListViewModel(movieId: raw.id,
                                                  movieProvider: movieProvider)
        
        reviews = ReviewListViewModel(movieId: raw.id,
                                      movieProvider: movieProvider)
        
        let isFetchInfoEnabled = _infoState
            .map { $0 == .overview }
        
        fetchInfo = Action(enabledIf: isFetchInfoEnabled) { _ in
            return movieProvider
                .fetchMovie(id: raw.id)
                .map { Info($0) }
        }
        
        toggleFavorite = Action (state: isFavorite.negate()) { value in
            if value == true {
                return movieProvider
                    .addToFavorites(movieId: raw.id)
                    .map { _ in value }
            }
            
            return movieProvider
                .removedFromFavorites(movieId: raw.id)
                .map { _ in value }
        }
        
        _infoState <~ fetchInfo
            .values
            .map { _ in return .detail }
        
        _genres <~ fetchInfo
            .values
            .map { $0.genres.value }
        
        _cast <~ fetchInfo
            .values
            .map { $0.cast.value }
        
        _crew <~ fetchInfo
            .values
            .map { $0.crew.value }
        
        _voteAverage <~ fetchInfo
            .values
            .map { $0.voteAverage.value }
        
        _isFavorite <~ toggleFavorite
            .values
        
        _isFavorite <~ fetchInfo
            .values
            .map { $0.isFavorite.value }
        
    }
}

extension MovieViewModel {
    public enum InfoState {
        case overview
        case detail
    }
    
    public struct Info {
        public let title: Property<String?>
        public let originalTitle: Property<String?>
        public let overview: Property<String?>
        public let genres: Property<[GenreViewModel]>
        public let posterURL: Property<URL?>
        public let cast: Property<[CastMemberViewModel]>
        public let crew: Property<[CrewMemberViewModel]>
        public let voteAverage: Property<Double>
        public let isFavorite: Property<Bool>
        
        init(_ raw: Movie) {
            
            title = Property(value: raw.title)
            originalTitle = Property(value: raw.originalTitle)
            overview = Property(value: raw.overview)
            genres = Property(value: raw.genres.map { GenreViewModel(raw: $0) })
            posterURL = Property(value: raw.posterURL)
            
            cast = Property(value: raw.credits.cast.map { CastMemberViewModel(raw: $0) })
            crew = Property(value: raw.credits.crew.map { CrewMemberViewModel(raw: $0) })
            
            voteAverage = Property(value: raw.voteAverage)
            
            isFavorite = Property(value: raw.isFavorite)
        }
    }
}

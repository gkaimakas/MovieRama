//
//  MovieOverview.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct MovieOverview {
    
    public let id: Int
    public let title: String?
    public let overview: String?
    public let genreIds: [Int]
    
    public let originalTitle: String?
    public let originalLanguage: String?
    
    public let posterPath: URL?
    public let backdropPath: URL?
    
    public let hasVideo: Bool
    public let isAdult: Bool
    
    public let voteCount: Int
    public let voteAverage: Double
    public let popularity: Double
    
    public let releasedAt: Date?
    
    public let isFavorite: Bool
    
    public init(id: Int,
                title: String?,
                overview: String?,
                genreIds: [Int],
                originalTitle: String?,
                originalLanguage: String?,
                posterPath: URL?,
                backdropPath: URL?,
                hasVideo: Bool,
                isAdult: Bool,
                voteCount: Int,
                voteAverage: Double,
                popularity: Double,
                releasedAt: Date?,
                isFavorite: Bool = false) {
        
        self.id = id
        self.title = title
        self.overview = overview
        self.genreIds = genreIds
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.hasVideo = hasVideo
        self.isAdult = isAdult
        self.voteCount = voteCount
        self.voteAverage = voteAverage
        self.popularity = popularity
        self.releasedAt = releasedAt
        self.isFavorite = isFavorite
    }
    
    func with(favorite: Bool) -> MovieOverview {
        return MovieOverview(id: id,
                             title: title,
                             overview: overview,
                             genreIds: genreIds,
                             originalTitle: originalTitle,
                             originalLanguage: originalLanguage,
                             posterPath: posterPath,
                             backdropPath: backdropPath,
                             hasVideo: hasVideo,
                             isAdult: isAdult,
                             voteCount: voteCount,
                             voteAverage: voteAverage,
                             popularity: popularity,
                             releasedAt: releasedAt,
                             isFavorite: favorite)
    }
}

extension MovieOverview: JSONDecodable { }

extension MovieOverview {
    struct Keys {
        static let voteCount = "vote_count"
        static let id = "id"
        static let video = "video"
        static let voteAverage = "vote_average"
        static let title = "title"
        static let popularity = "popularity"
        static let posterPath = "poster_path"
        static let originalLanguage = "original_language"
        static let originalTitle = "original_title"
        static let genreIds = "genre_ids"
        static let backdropPath = "backdrop_path"
        static let adult = "adult"
        static let overview = "overview"
        static let releasedAt = "release_date"
    }
}

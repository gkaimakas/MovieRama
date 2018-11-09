//
//  Movie.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct Movie {
    public let id: Int
    public let title: String?
    public let originalTitle: String?
    public let overview: String?
    public let genres: [Genre]
    public let posterURL: URL?
    public let credits: Credits
    public let voteAverage: Double
    public let isFavorite: Bool
    
    public init(id: Int,
                title: String?,
                originalTitle: String?,
                overview: String?,
                genres: [Genre],
                posterURL: URL?,
                credits: Credits,
                voteAverage: Double,
                isFavorite: Bool = false) {
        
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.genres = genres
        self.posterURL = posterURL
        self.credits = credits
        self.voteAverage = voteAverage
        self.isFavorite = isFavorite
    }
    
    func with(favorite: Bool) -> Movie {
        return Movie(id: id,
                     title: title,
                     originalTitle: originalTitle,
                     overview: overview,
                     genres: genres,
                     posterURL: posterURL,
                     credits: credits,
                     voteAverage: voteAverage,
                     isFavorite: favorite)
    }
}

extension Movie: JSONDecodable { }

extension Movie {
    struct Keys {
        static let id = "id"
        static let title = "title"
        static let originalTitle = "original_title"
        static let overview = "overview"
        static let genres = "genres"
        static let posterURL = "poster_path"
        static let voteAverage = "vote_average"
        static let credits = "credits"
    }
}

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
    
    public init(id: Int,
                title: String?,
                originalTitle: String?,
                overview: String?,
                genres: [Genre],
                posterURL: URL?,
                credits: Credits) {
        
        self.id = id
        self.title = title
        self.originalTitle = originalTitle
        self.overview = overview
        self.genres = genres
        self.posterURL = posterURL
        self.credits = credits
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
        static let credits = "credits"
    }
}

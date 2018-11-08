//
//  MovieDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class MovieDecoder: MovieRamaCommon.JSONDecoder<Movie> {
    let genreDecoder: MovieRamaCommon.JSONDecoder<Genre>
    let creditsDecoder:  MovieRamaCommon.JSONDecoder<Credits>
    
    init(genreDecoder: MovieRamaCommon.JSONDecoder<Genre> = GenreDecoder(),
         creditsDecoder:  MovieRamaCommon.JSONDecoder<Credits> = CreditsDecoder()) {
        
        self.genreDecoder = genreDecoder
        self.creditsDecoder = creditsDecoder
    }
    
    override func decode(json: JSON) throws -> Movie {
        let genres = try json.jsonList(key: Movie.Keys.genres)
            .map { try self.genreDecoder.decode(json: $0) }
        
        let credits = try creditsDecoder.decode(json: try json.json(key: Movie.Keys.credits))
        
        return Movie(id: try json.int(key: Movie.Keys.id),
                     title: try? json.string(key: Movie.Keys.title),
                     originalTitle: try? json.string(key: Movie.Keys.originalTitle),
                     overview: try? json.string(key: Movie.Keys.overview),
                     genres: genres,
                     posterURL: try? json.url(key: Movie.Keys.posterURL),
                     credits: credits)
        
    }
}

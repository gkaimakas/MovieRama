//
//  PagedMovieOverviewDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class PagedMovieOverviewDecoder: MovieRamaCommon.JSONDecoder<Page<MovieOverview>> {
    let movieOverviewDecoder: MovieRamaCommon.JSONDecoder<MovieOverview>
    
    init(movieOverviewDecoder: MovieRamaCommon.JSONDecoder<MovieOverview> = MovieOverviewDecoder()) {
        self.movieOverviewDecoder = movieOverviewDecoder
    }
    
    override func decode(json: JSON) throws -> Page<MovieOverview> {
        let page = try json.int(key: "page")
        let totalPages = try json.int(key: "total_pages")
        let totalResults = try json.int(key: "total_results")
        let results = try json
            .jsonList(key: "results")
            .map { json -> MovieOverview in
                return try self.movieOverviewDecoder
                    .decode(json: json)
            }
        
        return Page<MovieOverview>(page: page,
                                   totalPages: totalPages,
                                   totalResults: totalResults,
                                   results: results)
    }
}

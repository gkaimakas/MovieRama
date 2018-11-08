//
//  PagedReviewDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class PagedReviewDecoder: MovieRamaCommon.JSONDecoder<Page<Review>> {
    let reviewDecoder: MovieRamaCommon.JSONDecoder<Review>
    
    init(reviewDecoder: MovieRamaCommon.JSONDecoder<Review> = ReviewDecoder()) {
        self.reviewDecoder = reviewDecoder
    }
    
    override func decode(json: JSON) throws -> Page<Review> {
        let page = try json.int(key: "page")
        let totalPages = try json.int(key: "total_pages")
        let totalResults = try json.int(key: "total_results")
        let results = try json
            .jsonList(key: "results")
            .map { json -> Review in
                return try self.reviewDecoder
                    .decode(json: json)
        }
        
        return Page(page: page,
                    totalPages: totalPages,
                    totalResults: totalResults,
                    results: results)
    }
}

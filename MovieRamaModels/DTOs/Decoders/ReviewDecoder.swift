//
//  ReviewDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class ReviewDecoder: MovieRamaCommon.JSONDecoder<Review> {
    override func decode(json: JSON) throws -> Review {
        return Review(id: try json.string(key: Review.Keys.id),
                      author: try? json.string(key: Review.Keys.author),
                      content: try? json.string(key: Review.Keys.content))
    }
}

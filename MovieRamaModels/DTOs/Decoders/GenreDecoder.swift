//
//  GenreDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class GenreDecoder: MovieRamaCommon.JSONDecoder<Genre> {
    override func decode(json: JSON) throws -> Genre {
        
        return Genre(id: try json.int(key: Genre.Keys.id),
                     name: try? json.string(key: Genre.Keys.name))
    }
}

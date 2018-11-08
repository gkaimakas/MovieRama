//
//  SpokenLanguageDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class SpokenLanguageDecoder: MovieRamaCommon.JSONDecoder<SpokenLanguage> {
    override func decode(json: JSON) throws -> SpokenLanguage {
        return SpokenLanguage(iso_639_1: try json.string(key: SpokenLanguage.Keys.iso_639_1),
                              name: try? json.string(key: SpokenLanguage.Keys.name))
    }
}

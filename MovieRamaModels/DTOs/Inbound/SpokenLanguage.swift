//
//  SpokenLanguage.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct SpokenLanguage {
    public let iso_639_1: String
    public let name: String?
    
    public init(iso_639_1: String,
                name: String?) {
        self.iso_639_1 = iso_639_1
        self.name = name
    }
}

extension SpokenLanguage: JSONDecodable { }

extension SpokenLanguage {
    struct Keys {
        static let iso_639_1 = "iso_639_1"
        static let name = "name"
    }
}

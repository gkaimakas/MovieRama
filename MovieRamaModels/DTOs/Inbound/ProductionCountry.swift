//
//  ProductionCountry.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct ProductionCountry {
    public let iso_3166_1: String
    public let name: String?
    
    public init(iso_3166_1: String,
                name: String?) {
        self.iso_3166_1 = iso_3166_1
        self.name = name
    }
}

extension ProductionCountry: JSONDecodable { }

extension ProductionCountry {
    struct Keys {
        static let iso_3166_1 = "iso_3166_1"
        static let name = "name"
    }
}

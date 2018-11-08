//
//  ProductionCountryDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class ProductionCountryDecoder: MovieRamaCommon.JSONDecoder<ProductionCountry> {
    override func decode(json: JSON) throws -> ProductionCountry {
        
        return ProductionCountry(iso_3166_1: try json.string(key: ProductionCountry.Keys.iso_3166_1),
                                 name: try? json.string(key: ProductionCountry.Keys.name))
    }
}

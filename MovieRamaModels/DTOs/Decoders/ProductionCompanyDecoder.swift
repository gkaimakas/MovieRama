//
//  ProductionCompanyDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class ProductionCompanyDecoder: MovieRamaCommon.JSONDecoder<ProductionCompany> {
    override func decode(json: JSON) throws -> ProductionCompany {
        return ProductionCompany(id: try json.int(key: ProductionCompany.Keys.id),
                                 name: try? json.string(key: ProductionCompany.Keys.name),
                                 logoURL: try? json.url(key: ProductionCompany.Keys.logoURL),
                                 coutryOfOrigin: try? json.string(key: ProductionCompany.Keys.countryOfOrigin))
    }
}

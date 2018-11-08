//
//  ProductionCompany.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct ProductionCompany {
    public let id: Int
    public let name: String?
    public let logoURL: URL?
    public let coutryOfOrigin: String?
    
    public init(id: Int,
                name: String?,
                logoURL: URL?,
                coutryOfOrigin: String?) {
        
        self.id = id
        self.name = name
        self.logoURL = logoURL
        self.coutryOfOrigin = coutryOfOrigin
        
    }
}

extension ProductionCompany: JSONDecodable {  }

extension ProductionCompany {
    struct Keys {
        static let id = "id"
        static let name = "name"
        static let logoURL = "logo_path"
        static let countryOfOrigin = "origin_country"
    }
}

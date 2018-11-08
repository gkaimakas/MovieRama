//
//  CastMember.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct CastMember {
    public let id: Int
    public let castId: Int
    public let creditId: String
    public let character: String?
    public let gender: String?
    public let name: String?
    public let order: Int
    
    public init(id: Int,
                castId: Int,
                creditId: String,
                character: String?,
                gender: String?,
                name: String?,
                order: Int) {
        
        self.id = id
        self.castId = castId
        self.creditId = creditId
        self.character = character
        self.gender = gender
        self.name = name
        self.order = order
    }
}

extension CastMember: JSONDecodable { }

extension CastMember {
    struct Keys {
        static let id = "id"
        static let castId = "cast_id"
        static let creditId = "credit_id"
        static let character = "character"
        static let gender = "gender"
        static let name = "name"
        static let order = "order"
    }
}

//
//  Genre.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct Genre {
    public let id: Int
    public let name: String?
    
    public init(id: Int,
                name: String?) {
        
        self.id = id
        self.name = name
    }
}

extension Genre: JSONDecodable { }

extension Genre {
    struct Keys {
        static let id = "id"
        static let name = "name"
    }
}

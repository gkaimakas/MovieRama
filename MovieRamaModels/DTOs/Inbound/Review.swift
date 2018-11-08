//
//  Review.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct Review {
    public let id: String
    public let author: String?
    public let content: String?
    
    public init(id: String,
                author: String?,
                content: String?) {
        
        self.id = id
        self.author = author
        self.content = content
    }
}

extension Review: JSONDecodable { }

extension Review {
    struct Keys {
        static let id = "id"
        static let author = "author"
        static let content = "content"
    }
}

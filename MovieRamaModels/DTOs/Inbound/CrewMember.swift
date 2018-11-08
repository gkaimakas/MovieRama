//
//  CrewMember.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct CrewMember {
    public let id: Int
    public let job: String?
    public let name: String?
    
    public init(id: Int,
                job: String?,
                name: String?) {
        
        self.id = id
        self.job = job
        self.name = name
    }
}

extension CrewMember: JSONDecodable { }

extension CrewMember {
    struct Keys {
        static let id = "id"
        static let job = "job"
        static let name = "name"
    }
}

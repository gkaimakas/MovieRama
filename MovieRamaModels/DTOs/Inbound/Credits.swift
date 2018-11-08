//
//  Credits.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

public struct Credits {
    public let cast: [CastMember]
    public let crew: [CrewMember]
    
    public init(cast: [CastMember],
                crew: [CrewMember]) {
        
        self.cast = cast
        self.crew = crew
    }
}

extension Credits: JSONDecodable { }

extension Credits {
    struct Keys {
        static let cast = "cast"
        static let crew = "crew"
    }
}

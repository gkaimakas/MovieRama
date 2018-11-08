//
//  File.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class CreditsDecoder: MovieRamaCommon.JSONDecoder<Credits> {
    let castDecoder: MovieRamaCommon.JSONDecoder<CastMember>
    let crewDecoder: MovieRamaCommon.JSONDecoder<CrewMember>
    
    init(castDecoder: MovieRamaCommon.JSONDecoder<CastMember> = CastMemberDecoder(),
         crewDecoder: MovieRamaCommon.JSONDecoder<CrewMember> = CrewMemberDecoder()) {
        
        self.castDecoder = castDecoder
        self.crewDecoder = crewDecoder
    }
    
    override func decode(json: JSON) throws -> Credits {
        let cast = try json.jsonList(key: Credits.Keys.cast)
            .map { try castDecoder.decode(json: $0) }
        let crew = try json.jsonList(key: Credits.Keys.crew)
            .map { try crewDecoder.decode(json: $0) }
        
        return Credits(cast: cast,
                       crew: crew)
    }
}

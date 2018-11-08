//
//  CastMemberDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class CastMemberDecoder: MovieRamaCommon.JSONDecoder<CastMember> {
    override func decode(json: JSON) throws -> CastMember {
        return CastMember(id: try json.int(key: CastMember.Keys.id),
                          castId: try json.int(key: CastMember.Keys.castId),
                          creditId: try json.string(key: CastMember.Keys.creditId),
                          character: try? json.string(key: CastMember.Keys.character),
                          gender: try? json.string(key: CastMember.Keys.gender),
                          name: try? json.string(key: CastMember.Keys.name),
                          order: try json.int(key: CastMember.Keys.order))
    }
}

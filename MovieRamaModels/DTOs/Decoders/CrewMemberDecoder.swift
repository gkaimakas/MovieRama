//
//  CrewMemberDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class CrewMemberDecoder: MovieRamaCommon.JSONDecoder<CrewMember> {
    override func decode(json: JSON) throws -> CrewMember {
        return CrewMember(id: try json.int(key: CrewMember.Keys.id),
                          job: try? json.string(key: CrewMember.Keys.job),
                          name: try? json.string(key: CrewMember.Keys.name))
    }
}

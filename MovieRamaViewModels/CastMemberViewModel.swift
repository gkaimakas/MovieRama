//
//  CastMemberViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift

public class CastMemberViewModel {
    public let character: Property<String?>
    public let name: Property<String?>
    public let order: Property<Int>
    
    public init(raw: CastMember) {
        character = Property(value: raw.character)
        name = Property(value: raw.name)
        order = Property(value: raw.order)
    }
}

//
//  CrewMemberViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift

public class CrewMemberViewModel {
    
    public let id: Property<Int>
    public let job: Property<String?>
    public let name: Property<String?>
    
    public init(raw: CrewMember) {
        id = Property(value: raw.id)
        job = Property(value: raw.job)
        name = Property(value: raw.name)
    }
}

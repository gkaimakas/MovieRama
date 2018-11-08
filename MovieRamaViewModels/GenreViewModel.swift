//
//  GenreViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class GenreViewModel {
    public let id: Property<Int>
    public let name: Property<String?>
    
    public init(raw: Genre) {
        id = Property(value: raw.id)
        name = Property(value: raw.name)
    }
}

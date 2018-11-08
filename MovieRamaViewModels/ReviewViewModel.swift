//
//  ReviewViewModel.swift
//  MovieRamaViewModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import MovieRamaModels
import ReactiveSwift
import Result

public class ReviewViewModel {
    public let id: Property<String>
    public let author: Property<String?>
    public let content: Property<String?>
    
    public init(raw: Review) {
        id = Property(value: raw.id)
        author = Property(value: raw.author)
        content = Property(value: raw.content)
    }
}

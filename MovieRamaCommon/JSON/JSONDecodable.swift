//
//  JSONDecodable.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import ReactiveSwift
import Result

public protocol JSONDecodable { }

extension JSONDecodable {
    public static var name: String {
        return String(describing: self)
    }
}

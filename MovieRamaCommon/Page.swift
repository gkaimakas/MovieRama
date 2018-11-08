//
//  Page.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation

public struct Page<T: JSONDecodable> {
    public let page: Int
    public let totalPages: Int
    public let totalResults: Int
    
    public let results: [T]
    
    public init(page: Int,
                totalPages: Int,
                totalResults: Int,
                results: [T]) {
        
        self.page = page
        self.totalPages = totalPages
        self.totalResults = totalResults
        self.results = results
    }
    
    public func mapResults<U: JSONDecodable>(transform: (T)-> U) -> Page<U> {
        return Page<U>(page: page,
                       totalPages: totalPages,
                       totalResults: totalResults,
                       results: results.map { transform($0) })
    }
}

extension Page: JSONDecodable { }

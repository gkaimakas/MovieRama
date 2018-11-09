//
//  URL+TMDB.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation

extension URL {
    public func poster(width: TMDBPosterSize) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/\(width.rawValue)")!.appendingPathComponent(absoluteString)
    }
    
    public func backdrop(width: TMDBBackdropSize) -> URL {
        return URL(string: "https://image.tmdb.org/t/p/\(width.rawValue)")!.appendingPathComponent(absoluteString)
    }
}

public enum TMDBPosterSize: String {
    case w92
    case w154
    case w185
    case w342
    case w500
    case w780
    case original
}

public enum TMDBBackdropSize: String {
    case w300
    case w780
    case w1280
    case original
}

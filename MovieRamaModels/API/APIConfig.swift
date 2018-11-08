//
//  APIConfig.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

struct APIConfig {
    static var tmdb: [String: Any] {
        guard let value = Bundle.main.infoDictionary?["TMDB"] as? [String: Any] else {
            fatalError("TMDB entry seems to be missing from Info.plist of MovieRama")
        }
        
        return value
    }
    
    static var apiURL: URL {
        guard let urlRaw = tmdb["api_url"] as? String,
            let url = URL(string: urlRaw) else {
                fatalError("api_url seems to be missing from Info.plist of MovieRama or is an invalid ULR")
        }
        
        return url
    }
    
    static var apiKey: String {
        guard let key = tmdb["api_key"] as? String else {
            fatalError("api_key seems to be missing from Info.plist of MovieRama")
        }
        
        return key
    }
}

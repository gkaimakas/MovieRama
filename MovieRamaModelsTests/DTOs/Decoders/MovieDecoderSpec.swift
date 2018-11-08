//
//  MovieDecoderSpec.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import Quick
import Nimble
@testable import MovieRamaModels

class MovieDecoderSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("MovieDecoder") {
            let data = NSDataAsset(name: "fetch_movie_by_id", bundle: Bundle(for: type(of: self)))!.data
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            it("should decode a movie") {
                do {
                    let result = try MovieDecoder().decode(json: json)
                    
                    expect(result).toNot(beNil())
                } catch let error {
                    print(error)
                }
            }
        }
    }
}

//
//  PagedReviewDecoderSpec.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon
import Quick
import Nimble
@testable import MovieRamaModels

class PagedReviewDecoderSpec: QuickSpec {
    override func spec() {
        super.spec()
        
        describe("PagedReviewDecoder") {
            let data = NSDataAsset(name: "fetch_movie_review_list", bundle: Bundle(for: type(of: self)))!.data
            let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String : Any]
            
            it("should decode a page") {
                let result = try? PagedReviewDecoder().decode(json: json)
                expect(result).toNot(beNil())
            }
        }
    }
}

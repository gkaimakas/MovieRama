//
//  JSONDecoder.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

public typealias JSON = [String: Any]

public protocol JSONDecoderProtocol {
    associatedtype T where T: JSONDecodable
    
    func decode(json: JSON) throws -> T
    func decodeList(json: JSON) throws -> [T]
}

open class JSONDecoder<T: JSONDecodable>: JSONDecoderProtocol {
    public init() { }
    
    open func decode(json: JSON) throws -> T {
        fatalError("Not Implemented. Subclass JSONDecoder and provide a concrete implementation")
    }
    
    open func decodeList(json: JSON) throws -> [T] {
        fatalError("Not Implemented. Subclass JSONDecoder and provide a concrete implementation")
    }
}

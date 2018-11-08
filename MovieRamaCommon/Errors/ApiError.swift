//
//  ApiError.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

public struct ApiError: Error {
    public let statusCode: Int
    public let statusMessage: String
    
    public init(statusCode: Int,
                statusMessage: String) {
        self.statusCode = statusCode
        self.statusMessage = statusMessage
    }
}

extension ApiError: JSONDecodable { }

public class ApiErrorDecoder: JSONDecoder<ApiError> {
    override public func decode(json: JSON) throws -> ApiError {
        let statusCode = try json.int(key: "status_code")
        let statusMessage = try json.string(key: "status_message")
        
        return ApiError(statusCode: statusCode,
                        statusMessage: statusMessage)
    }
}

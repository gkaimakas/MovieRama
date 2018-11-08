//
//  RemoteProviderError.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

public enum RemoteProviderError: Error {
    case json(JSONDecodeError)
    case request(statusCode: Int?, error: ApiError?)
    case timeOut
    case unknown(error: Error)
    case invalidResponseFormat
}

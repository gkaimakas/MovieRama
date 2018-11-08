//
//  API+SignalProducer.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Alamofire
import Foundation
import MovieRamaCommon
import ReactiveSwift

import enum Result.Result
import enum Result.NoError
import struct Result.AnyError

extension SignalProducer where Value == DataResponse<Any>, Error == NoError {
    func promoteRemoteProviderError(errorDecoder: MovieRamaCommon.JSONDecoder<ApiError> = ApiErrorDecoder()) -> SignalProducer<Any, RemoteProviderError> {
        
        return self
            .promoteError(RemoteProviderError.self)
            .attemptMap { (response: DataResponse<Any>) -> Result<Any, RemoteProviderError> in
                
                switch response.result {
                case .success(let value):
                    return Result.success(value)
                    
                case .failure:
                    if let jsonNullable = try? JSONSerialization.jsonObject(with: response.data!, options: []) as? [String: Any],
                        let json = jsonNullable,
                        let error = try? errorDecoder.decode(json: json) {
                        return Result.failure(RemoteProviderError.request(statusCode: response.response?.statusCode, error: error))
                    }
                    return Result.failure(RemoteProviderError.request(statusCode: response.response?.statusCode, error: nil))
                }
        }
    }
}

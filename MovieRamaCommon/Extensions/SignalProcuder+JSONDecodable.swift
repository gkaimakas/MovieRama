//
//  SignalProcuder+JSONDecodable.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import ReactiveSwift
import Result

public extension SignalProducer where Value == Any, Error == RemoteProviderError {
    func decode<T, JSONDecoder: JSONDecoderProtocol>(using decoder: JSONDecoder) -> SignalProducer<T, RemoteProviderError>  where JSONDecoder.T == T {
        
        return self
            .attemptMap({ data -> Result<T, RemoteProviderError> in
                return Result<T, RemoteProviderError>.init(attempt: { () -> T in
                    guard let json = data as? JSON else {
                        throw RemoteProviderError.invalidResponseFormat
                    }
                    do {
                        return try decoder.decode(json: json)
                    } catch let error as JSONDecodeError {
                        throw RemoteProviderError.json(error)
                    }
                })
            })
    }
    
    func decodeList<T, JSONDecoder: JSONDecoderProtocol>(using decoder: JSONDecoder) -> SignalProducer<[T], RemoteProviderError>  where JSONDecoder.T == T {
        
        return self
            .attemptMap({ data -> Result<[T], RemoteProviderError> in
                return Result<[T], RemoteProviderError>.init(attempt: { () -> [T] in
                    guard let json = data as? JSON else {
                        throw RemoteProviderError.invalidResponseFormat
                    }
                    do {
                        return try decoder.decodeList(json: json)
                    } catch let error as JSONDecodeError {
                        throw RemoteProviderError.json(error)
                    }
                })
            })
    }
}

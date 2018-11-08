//
//  ProviderError.swift
//  MovieRamaCommon
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation

public enum ProviderError: Swift.Error {
    case remote(RemoteProviderError)
    case local(LocalProviderError)
}

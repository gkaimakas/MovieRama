//
//  RemoteProvider.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Alamofire
import Foundation

public class RemoteProvider {
    let sessionManager: SessionManager
    
    public init(sessionManager: SessionManager = SessionManager.default) {
        self.sessionManager = sessionManager
    }
}

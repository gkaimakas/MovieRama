//
//  Container.swift
//  MovieRama
//
//  Created by George Kaimakas on 09/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Foundation
import MovieRamaCommon
import MovieRamaModels
import MovieRamaViewModels
import Swinject

class MovieRamaContainer {
    let container: Container
    
    init() {
        container = Container()
        
        container
            .register(MovieProviderProtocol.self) { r in
                return MovieProvider(localProvider: MovieLocalProvider(),
                                     remoteProvider: MovieRemoteProvider())
            }
            .inObjectScope(.container)
        
        container
            .register(PopularMovieListViewModel.self) { r in
                return PopularMovieListViewModel(movieProvider: r.resolve(MovieProviderProtocol.self)!)
            }
            .inObjectScope(.container)
            
    }
    
    func resolve<Service>(_ serviceType: Service.Type) -> Service? {
        return container.resolve(serviceType)
    }
}

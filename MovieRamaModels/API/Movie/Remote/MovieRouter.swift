//
//  MovieRouter.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import Alamofire
import MovieRamaCommon

enum MovieRouter: URLRequestConvertible {
    case fetchPopularMovieList(page: Int)
    case search(query: String, page: Int)
    case fetchMovie(id: Int)
    case fetchReviews(movieId: Int, page: Int)
    
    var httpMethod: Alamofire.HTTPMethod {
        switch self {
        case .fetchPopularMovieList:
            return .get
        case .search:
            return .get
        case .fetchMovie:
            return .get
        case .fetchReviews:
            return .get
            
        }
    }
    
    var encoding: Alamofire.ParameterEncoding {
        switch self {
        case .fetchPopularMovieList:
            return URLEncoding.default
        case .search:
            return URLEncoding.default
        case .fetchMovie:
            return URLEncoding.default
        case .fetchReviews:
            return URLEncoding.default
            
        }
    }
    
    var requestConfiguration: (path: String, parameters: [String: Any]?, body: [String: Any]?) {
        switch self {
            
        case .fetchPopularMovieList(let page):
            return (
                path: "/movie/popular",
                parameters: [
                    "api_key": APIConfig.apiKey,
                    "page": page
                ],
                body: nil
            )
            
        case .search(let query, let page):
            return (
                path: "/search/movie",
                parameters: [
                    "api_key": APIConfig.apiKey,
                    "query": query,
                    "page": page
                ],
                body: nil
            )
            
        case .fetchMovie(let id):
            return (
                path: "/movie/\(id)",
                parameters: [
                    "api_key": APIConfig.apiKey,
                    "append_to_response": "credits"
                ],
                body: nil
            )
            
        case .fetchReviews(let movieId, let page):
            return (
                path: "/movie/\(movieId)/reviews",
                parameters: [
                    "api_key": APIConfig.apiKey,
                    "page": page
                ],
                body: nil
            )
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let config = self.requestConfiguration
        
        let url = APIConfig.apiURL.appendingPathComponent(config.path)
        var urlRequest = URLRequest(url: url)
        
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest = try encoding.encode(urlRequest, with: config.body)
        urlRequest = try URLEncoding(destination: .queryString,
                                     arrayEncoding: .brackets,
                                     boolEncoding: .numeric).encode(urlRequest, with: config.parameters)
        
        return urlRequest
    }
}

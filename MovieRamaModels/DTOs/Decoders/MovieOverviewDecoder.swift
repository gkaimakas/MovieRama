//
//  MovieOverviewDecoder.swift
//  MovieRamaModels
//
//  Created by George Kaimakas on 08/11/2018.
//  Copyright © 2018 George Kaimakas. All rights reserved.
//

import MovieRamaCommon

class MovieOverviewDecoder: MovieRamaCommon.JSONDecoder<MovieOverview> {
    override func decode(json: JSON) throws -> MovieOverview {
        let genreIds: [Int] = (try? json.array(key: MovieOverview.Keys.genreIds)) ?? []

        return MovieOverview(id: try json.int(key: MovieOverview.Keys.id),
                             title: try? json.string(key: MovieOverview.Keys.title),
                             overview: try? json.string(key: MovieOverview.Keys.overview),
                             genreIds: genreIds,
                             originalTitle: try? json.string(key: MovieOverview.Keys.originalTitle),
                             originalLanguage: try? json.string(key: MovieOverview.Keys.originalLanguage),
                             posterPath: try? json.url(key: MovieOverview.Keys.posterPath),
                             backdropPath: try? json.url(key: MovieOverview.Keys.backdropPath),
                             hasVideo: try json.bool(key: MovieOverview.Keys.video),
                             isAdult: try json.bool(key: MovieOverview.Keys.adult),
                             voteCount: try json.int(key: MovieOverview.Keys.voteCount),
                             voteAverage: try json.double(key: MovieOverview.Keys.voteAverage),
                             popularity: try json.double(key: MovieOverview.Keys.popularity),
                             releasedAt: try? json.dateFromString(key: MovieOverview.Keys.releasedAt))
    }
}

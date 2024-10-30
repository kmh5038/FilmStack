//
//  TMDBModels.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

struct TMDBMovieResponse: Codable {
    let results: [TMDBMovie]
}

struct TMDBMovie: Codable {
    let posterPath: String?
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
    }
}

struct TMDBSearchResponse: Codable {
    let results: [TMDBSearchResult]
}

struct TMDBSearchResult: Codable {
    let id: Int
    let title: String
    let posterPath: String?
    let releaseDate: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
        case releaseDate = "release_date"
    }
    
    var posterURL: URL? {
        guard let posterPath = posterPath else { return nil }
        return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
    }
}

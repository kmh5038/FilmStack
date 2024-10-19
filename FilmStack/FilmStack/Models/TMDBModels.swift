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

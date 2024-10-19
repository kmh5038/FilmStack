//
//  MovieInfoModel.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

struct MovieInfoModel: Codable, Hashable {
    let boxOfficeInfo: BoxOfficeMovieModel
    let runtime: String?
    let posterURL: URL?
    var id: String { boxOfficeInfo.movieCd ?? "" }
}

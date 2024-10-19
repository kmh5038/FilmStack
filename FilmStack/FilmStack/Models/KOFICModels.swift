//
//  KOFICModels.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

// KOFIC BoxOffice API 모델
struct BoxOfficeResponse: Codable {
    let boxOfficeResult: BoxOfficeResult?
}

struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String?
    let dailyBoxOfficeList: [BoxOfficeMovieModel]?
}

// KOFIC MovieInfo API 모델
struct MovieDetailResponse: Codable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
    let showTm: String
}

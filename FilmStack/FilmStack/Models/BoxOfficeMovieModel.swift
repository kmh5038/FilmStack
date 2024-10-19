//
//  BoxOfficeMovieModel.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

struct BoxOfficeMovieModel: Codable, Hashable {
    let rank: String?
    let movieNm: String?
    let openDt: String?
    let audiAcc: String?
    let movieCd: String?
    var id: String { movieCd ?? UUID().uuidString }
}


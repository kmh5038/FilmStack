//
//  KOFICAPIClient.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

class KOFICAPIClient {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    func fetchDailyBoxOfficeList(date: String) async throws -> [BoxOfficeMovieModel] {
        let urlString = "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)"
        guard let url = URL(string: urlString) else { return [] }
        let (data, _) = try await URLSession.shared.data(from: url)
        let movies = try JSONDecoder().decode(BoxOfficeResponse.self, from: data)
        
        return movies.boxOfficeResult?.dailyBoxOfficeList ?? []
    }
    
    func fetchMovieRuntime(movieCd: String) async throws -> String {
        let urlString = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(apiKey)&movieCd=\(movieCd)"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        let (data, _) = try await URLSession.shared.data(from: url)
        let movieDetailResponse = try JSONDecoder().decode(MovieDetailResponse.self, from: data)
        
        return movieDetailResponse.movieInfoResult.movieInfo.showTm
    }
}


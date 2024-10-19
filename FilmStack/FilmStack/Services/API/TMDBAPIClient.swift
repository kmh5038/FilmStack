//
//  TMDBAPIClient.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

class TMDBAPIClient {
    private let apiKey: String
    
    init(apiKey: String) {
        self.apiKey = apiKey
    }
    
    private func fetchMoviePosterURL(title: String) async throws -> URL? {
        let query = title.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
        let urlString = "https://api.themoviedb.org/3/search/movie?api_key=\(apiKey)&query=\(query)&language=ko-KR"
        guard let url = URL(string: urlString) else { throw URLError(.badURL) }
        
        let (data, _) = try await URLSession.shared.data(from: url)
        let tmdbResponse = try JSONDecoder().decode(TMDBMovieResponse.self, from: data)
        
        if let posterPath = tmdbResponse.results.first?.posterPath {
            return URL(string: "https://image.tmdb.org/t/p/w500\(posterPath)")
        }
        return nil
    }
    
    // Kofic에서 받아온 영화제목과 TMDB에서 검색한 영화제목이 여백차이로 일치하지않아 사용
    func searchPosterURL(title: String) async throws -> URL? {
        let searchTitles = [
            title,  // 원본 제목
            title.addingSpaceBeforeNumbers(),  // 숫자 앞에 공백 추가
            title.removingSpaceBeforeNumbers(),  // 숫자 앞의 공백 제거
            title.replacingOccurrences(of: " ", with: ""),  // 모든 공백 제거
        ]
        
        for searchTitle in searchTitles {
            if let url = try await fetchMoviePosterURL(title: searchTitle) {
                print("\(searchTitle) 포스터 찾음")  // 디버깅용
                return url
            }
        }
        print("\(title) 포스터 못찾음")  // 디버깅용
        return nil
    }
}

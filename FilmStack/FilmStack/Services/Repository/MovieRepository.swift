//
//  MovieRepository.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

class MovieRepository {
    private let koficClient: KOFICAPIClient
    private let tmdbClient: TMDBAPIClient
    private let cacheManager: MovieCacheManager
    
    init(koficClient: KOFICAPIClient, tmdbClient: TMDBAPIClient) {
        self.koficClient = koficClient
        self.tmdbClient = tmdbClient
        self.cacheManager = MovieCacheManager.shared
    }
    
    func fetchDailyBoxOfficeWithDetails(for date: String) async throws -> [MovieInfoModel] {
        cacheManager.printCacheStatus()
        
        // 캐시가 유효한지 확인
        if cacheManager.isCacheValid() {
            if let cachedMovies = cacheManager.getCachedMovies() {
                return cachedMovies
            }
        }
        
        // 캐시가 유효하지 않으면 새로운 데이터 가져오기
        let boxOfficeList = try await koficClient.fetchDailyBoxOfficeList(date: date)
        
        print("박스오피스 목록 가져옴, 상세 정보 가져오기 시작")
        let movies = try await withThrowingTaskGroup(of: MovieInfoModel?.self) { group in
            for movie in boxOfficeList {
                group.addTask {
                    async let runtime = self.koficClient.fetchMovieRuntime(movieCd: movie.movieCd ?? "")
                    async let posterURL = self.tmdbClient.searchPosterURL(title: movie.movieNm ?? "")
                    
                    let fetchedRuntime = try await runtime
                    let fetchedPosterURL = try await posterURL
                    
                    return MovieInfoModel(
                        boxOfficeInfo: movie,
                        runtime: fetchedRuntime,
                        posterURL: fetchedPosterURL
                    )
                }
            }
            
            var detailedMovies: [MovieInfoModel] = []
            for try await movie in group {
                if let movie = movie {
                    detailedMovies.append(movie)
                }
            }
            
            return detailedMovies.sorted {
                guard let rank1 = Int($0.boxOfficeInfo.rank ?? ""),
                      let rank2 = Int($1.boxOfficeInfo.rank ?? "") else {
                    return false
                }
                return rank1 < rank2
            }
        }
        
        // 새로운 데이터를 캐시에 저장
        cacheManager.cacheMovies(movies)
        print("\n새로운 캐시 상태:")
        cacheManager.printCacheStatus()
        
        return movies
    }
    
    func searchMovies(title: String) async throws -> [TMDBSearchResult] {
        // 빈 검색어 체크
        guard !title.isEmpty else {
            return []
        }
        
        let searchResults = try await tmdbClient.searchMovies(title: title)
        
        return searchResults
    }
}


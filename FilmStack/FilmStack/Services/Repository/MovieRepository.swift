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
    private let cacheManager: MovieCacheManager // 선언
    
    init(koficClient: KOFICAPIClient, tmdbClient: TMDBAPIClient) {
        self.koficClient = koficClient
        self.tmdbClient = tmdbClient
        self.cacheManager = MovieCacheManager.shared // 초기화
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
            
            return detailedMovies.sorted { $0.boxOfficeInfo.rank ?? "" < $1.boxOfficeInfo.rank ?? "" }
        }
        
        // 새로운 데이터를 캐시에 저장
        cacheManager.cacheMovies(movies)
        print("\n새로운 캐시 상태:")
        cacheManager.printCacheStatus()
        
        return movies
    }
}


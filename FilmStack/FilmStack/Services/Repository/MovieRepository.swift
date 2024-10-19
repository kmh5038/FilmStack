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
    
    init(koficClient: KOFICAPIClient, tmdbClient: TMDBAPIClient) {
        self.koficClient = koficClient
        self.tmdbClient = tmdbClient
    }
    
    func fetchDailyBoxOfficeWithDetails(for date: String) async throws -> [MovieInfoModel] {
        let boxOfficeList = try await koficClient.fetchDailyBoxOfficeList(date: date)
        
        return try await withThrowingTaskGroup(of: MovieInfoModel?.self) { group in
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
    }
}


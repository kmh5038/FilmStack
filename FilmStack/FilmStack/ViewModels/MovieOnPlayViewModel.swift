//
//  MovieOnPlayViewModel.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation
import SwiftUI

class MovieOnPlayViewModel: ObservableObject {
    @Published var movies: [MovieInfoModel] = []
    
    private let koficClient: KOFICAPIClient
    private let tmdbClient: TMDBAPIClient
    
    init(koficClient: KOFICAPIClient = KOFICAPIClient(apiKey: APIKeyManager.shared.koficApiKey),
         tmdbClient: TMDBAPIClient = TMDBAPIClient(apiKey: APIKeyManager.shared.tmdbApiKey)
    ) {
        self.koficClient = koficClient
        self.tmdbClient = tmdbClient
    }
    
    func loadMovieInfo() async {
        do {
            let yesterdayDate = DateFormatter.yesterdayString()
            let boxOfficeMovies = try await koficClient.fetchDailyBoxOfficeList(date: yesterdayDate)
            
            let detailedMovies = await withTaskGroup(of: MovieInfoModel?.self) { group in
                for movie in boxOfficeMovies {
                    group.addTask {
                        await self.fetchMovieDetails(for: movie)
                    }
                }
                
                var results: [MovieInfoModel] = []
                for await detailedMovie in group {
                    if let movie = detailedMovie {
                        results.append(movie)
                    }
                }
                return results
            }
            
            await MainActor.run {
                self.movies = detailedMovies.sorted {
                    guard let rank1 = Int($0.boxOfficeInfo.rank ?? ""),
                          let rank2 = Int($1.boxOfficeInfo.rank ?? "") else {
                        return false
                    }
                    return rank1 < rank2
                }
            }
        } catch {
            await MainActor.run {
                print("Error loading films: \(error)")
                // 여기에 사용자에게 에러를 표시하는 로직을 추가할 수 있습니다.
            }
        }
    }
    
    private func fetchMovieDetails(for movie: BoxOfficeMovieModel) async -> MovieInfoModel? {
        do {
            async let runtime = koficClient.fetchMovieRuntime(movieCd: movie.movieCd ?? "")
            async let posterURL = tmdbClient.searchPosterURL(title: movie.movieNm ?? "")
            
            return MovieInfoModel(
                boxOfficeInfo: movie,
                runtime: try await runtime,
                posterURL: try await posterURL
            )
        } catch {
            print("Error fetching details for movie \(movie.movieNm ?? ""): \(error)")
            return nil
        }
    }
}

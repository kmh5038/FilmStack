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
    @Published var isLoading = false
    
    private let repository: MovieRepository
    private let cacheManager = MovieCacheManager.shared
    
    init(koficClient: KOFICAPIClient = KOFICAPIClient(apiKey: APIKeyManager.shared.koficApiKey),
         tmdbClient: TMDBAPIClient = TMDBAPIClient(apiKey: APIKeyManager.shared.tmdbApiKey)
    ) {
        self.repository = MovieRepository(koficClient: koficClient, tmdbClient: tmdbClient)
    }
    
    @MainActor
    func loadMovieInfo() async {
        isLoading = true
        print("\n===== 영화 데이터 로딩 시작 =====")
        
        do {
            let yesterdayDate = DateFormatter.yesterdayString()
            print("요청 날짜: \(yesterdayDate)")
            
            // repository를 통해 데이터 가져오기
            movies = try await repository.fetchDailyBoxOfficeWithDetails(for: yesterdayDate)
        } catch {
            print("Error loading films: \(error)")
            // 에러 처리 로직 추가 가능
        }
        
        isLoading = false
    }
}

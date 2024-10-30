//
//  MovieSearchViewModel.swift
//  FilmStack
//
//  Created by 김명현 on 10/30/24.
//

import Foundation

class MovieSearchViewModel: ObservableObject {
    @Published var searchResults: [TMDBSearchResult] = []
    @Published var isLoading: Bool = false
    
    private let repository: MovieRepository
    private var searchTask: Task<Void, Never>?
    
    init(koficClient: KOFICAPIClient = KOFICAPIClient(apiKey: APIKeyManager.shared.koficApiKey),
         tmdbClient: TMDBAPIClient = TMDBAPIClient(apiKey: APIKeyManager.shared.tmdbApiKey)
    ) {
        self.repository = MovieRepository(koficClient: koficClient, tmdbClient: tmdbClient)
    }
    
    // 입력에 대한 디바운스 처리된 검색 수행
    func debounceSearchMovies(title: String) {
        // 이전 검색 작업 취소
        searchTask?.cancel()
        
        // 빈 검색어 처리
        guard !title.isEmpty else {
            searchResults = []
            return
        }
        
        // 새로운 검색 작업 시작(디바운스 처리)
        searchTask = Task {
            try? await Task.sleep(nanoseconds: 1_000_000_000)
            guard !Task.isCancelled else { return }
            await loadSearchMovie(title: title)
        }
    }
    
    // 실제 검색 수행
    @MainActor
    private func loadSearchMovie(title: String) async {
        isLoading = true
        
        do {
            searchResults = try await repository.searchMovies(title: title)
        } catch {
            print("검색 에러: \(error)")
            searchResults = []
        }
    }
}

//
//  MovieCacheManager.swift
//  FilmStack
//
//  Created by 김명현 on 10/29/24.
//

import Foundation

class MovieCacheManager {
    static let shared = MovieCacheManager()
    private let userDefaults = UserDefaults.standard
    private let lastUpdateTimeKey = "lastUpdateTime"
    private let cachedMoviesKey = "cachedMovies"
    
    private init() { }
    
    // 캐시 유효성 검사
    func isCacheValid() -> Bool {
        guard let lastUpdate = userDefaults.object(forKey: lastUpdateTimeKey) as? Date else {
            print("마지막 업데이트 시간 없음") // 디버깅용
            return false
        }
        
        let calendar = Calendar.current
        let now = Date()
        let todayMidnight = calendar.startOfDay(for: now)
        
        return lastUpdate >= todayMidnight
    }
    
    // 영화 데이터 캐시에 저장
    func cacheMovies(_ movies: [MovieInfoModel]) {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(movies)
            
            userDefaults.set(encodedData, forKey: cachedMoviesKey)
            userDefaults.set(Date(), forKey: lastUpdateTimeKey)
        } catch {
            print("영화 데이터 캐싱 실패: \(error.localizedDescription)")
        }
    }
    
    // 캐시된 영화 데이터 가져오기
    func getCachedMovies() -> [MovieInfoModel]? {
        guard let data = userDefaults.data(forKey: cachedMoviesKey) else {
            print("캐시된 데이터 없음") // 디버깅용
            return nil
        }
        do {
            let decoder = JSONDecoder()
            let movies = try decoder.decode([MovieInfoModel].self, from: data)
            // 순위별로 정렬
            let sortedMovies = movies.sorted {
                Int($0.boxOfficeInfo.rank ?? "0") ?? 0 < Int($1.boxOfficeInfo.rank ?? "0") ?? 0
            }
            return sortedMovies
        } catch {
            print("캐시된 영화 데이터 디코딩 실패: \(error)")
            return nil
        }
    }
    
    // 캐시 삭제
    func clearCache() {
        userDefaults.removeObject(forKey: cachedMoviesKey)
        userDefaults.removeObject(forKey: lastUpdateTimeKey)
    }
    
    func printCacheStatus() {
        print("===== 캐시 상태 =====")
        
        if let movies = getCachedMovies() {
            print("캐시된 데이터 로드 성공 (\(movies.count)개)")
            print("캐시된 영화 수: \(movies.count)")
            print("캐시된 영화 목록:")
            movies.forEach { movie in
                print("- \(movie.boxOfficeInfo.movieNm ?? "제목 없음") (순위: \(movie.boxOfficeInfo.rank ?? ""))")
            }
        } else {
            print("캐시된 영화 데이터 없음")
        }
        print("===================")
    }
}


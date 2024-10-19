//
//  APIKeyManager.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation

class APIKeyManager {
    static let shared = APIKeyManager()
    private init () { }
    
    var koficApiKey: String {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "KOFIC_BOXOFFICE_API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apiKey
    }
    
    var tmdbApiKey: String {
        guard let apikey = Bundle.main.object(forInfoDictionaryKey: "TMDB_MOVIE_INFO_API_KEY") as? String else {
            fatalError("API_KEY not found in Info.plist")
        }
        return apikey
    }
}

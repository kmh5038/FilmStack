//
//  ContentView.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var movieOnPlayViewModel = MovieOnPlayViewModel()
    
    var body: some View {
        ZStack {
            TabView {
                MovieOnPlayView(viewModel: movieOnPlayViewModel)
                    .tabItem {
                        Image(systemName: "film")
                        Text("상영중 영화")
                    }
                
                MovieSearchView()
                    .tabItem {
                        Image(systemName: "magnifyingglass")
                        Text("영화 검색")
                    }
            }
            .tint(.white)
            .onAppear {
                let appearance = UITabBarAppearance()
                appearance.configureWithOpaqueBackground()
                appearance.backgroundColor = .black
                
                // 탭바 상단에 회색 경계선 추가
                appearance.shadowImage = UIImage()
                appearance.shadowColor = .systemGray6
                
                UITabBar.appearance().standardAppearance = appearance
                UITabBar.appearance().scrollEdgeAppearance = appearance
            }
        }
    }
}

#Preview {
    ContentView()
}

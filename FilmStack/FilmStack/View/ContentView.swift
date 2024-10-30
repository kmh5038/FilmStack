//
//  ContentView.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var movieOnPlayViewModel = MovieOnPlayViewModel()
    @StateObject private var movieSearchViewModel = MovieSearchViewModel()
    @State private var selectedTab = 0
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.main.edgesIgnoringSafeArea(.all)
                
                VStack {
                    TabView(selection: $selectedTab) {
                        VStack {
                            Spacer().frame(height: 10)
                        }
                        MovieOnPlayView(viewModel: movieOnPlayViewModel)
                            .tag(0)
                        
                        FlimStackView(viewModel: movieSearchViewModel)
                            .tag(1)
                        
                        UserInfoView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    CustomTabView(selectedTab: $selectedTab)
                }
            }
            .tint(.white)
            .navigationBarTitleDisplayMode(.inline)
        }
        .onAppear {
            // 타이틀 영역
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.backgroundColor = UIColor.main
            
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            
            // 탭바 영역
            let tabViewAppearance = UITabBarAppearance()
            // 탭바 배경색
            tabViewAppearance.configureWithOpaqueBackground()
            tabViewAppearance.backgroundColor = UIColor.tebView
            
            // 탭바 상단에 회색 경계선 추가
            tabViewAppearance.shadowImage = UIImage()
            tabViewAppearance.shadowColor = .systemGray2
            
            UITabBar.appearance().standardAppearance = tabViewAppearance
            UITabBar.appearance().scrollEdgeAppearance = tabViewAppearance
        }
    }
}

//#Preview {
//    ContentView()
//}

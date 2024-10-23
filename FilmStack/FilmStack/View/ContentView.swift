//
//  ContentView.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var movieOnPlayViewModel = MovieOnPlayViewModel()
    @State private var selectedTab = 0
    
    let tabs = [
            (image: "popcorn", title: "상영중 영화"),
            (image: "magnifyingglass", title: "필름 스택"),
            (image: "person", title: "프로필")
        ]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color.main.edgesIgnoringSafeArea(.all)
                
                VStack {
                    TabView(selection: $selectedTab) {
                        VStack {
                            Spacer().frame(height: 10)
                        }
                        MovieOnPlayView(viewModel: movieOnPlayViewModel)
                            .tag(0)
                        
                        MovieSearchView()
                            .tag(1)
                        
                        UserInfoView()
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                    
                    CustomTabView(selectedTab: $selectedTab, tabs: tabs)
                }
            }
            .tint(.white)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Text(tabs[selectedTab].title)
                        .foregroundStyle(.white)
                        .font(.system(size: 20, weight: .bold, design: .rounded))
                        .padding([.bottom, .leading], 10)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        
                    } label: {
                        if selectedTab == 1 {
                            Image(systemName: "plus")
                                .resizable()
                                .frame(width: 20, height: 20)
                                .foregroundStyle(.white)
                                .fontWeight(.semibold)
                                .padding(.trailing, 10)
                        }
                    }
                }
            }
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

#Preview {
    ContentView()
}

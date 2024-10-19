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
        TabView {
            MovieOnPlayView(viewModel: movieOnPlayViewModel)
                .tabItem {
                    Image(systemName: "1.square.fill")
                    Text("상영중 영화")
                }
        }
    }
}

#Preview {
    ContentView()
}

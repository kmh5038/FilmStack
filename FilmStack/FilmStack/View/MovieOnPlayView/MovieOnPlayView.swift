//
//  MovieOnPlayView.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation
import SwiftUI

struct MovieOnPlayView: View {
    @ObservedObject var viewModel: MovieOnPlayViewModel
    
    var body: some View {
        VStack {
            MovieListView(movies: viewModel.movies)
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Text("상영중 영화")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding([.bottom, .leading], 10)
            }
        }
        .onAppear {
            Task {
                await viewModel.loadMovieInfo()
            }
        }
        
    }
} 

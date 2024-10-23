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
        .onAppear {
            Task {
                await viewModel.loadMovieInfo()
            }
        }
        
    }
} 

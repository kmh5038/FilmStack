//
//  MovieSearchView.swift
//  FilmStack
//
//  Created by 김명현 on 10/30/24.
//

import SwiftUI

struct MovieSearchView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: MovieSearchViewModel
    @State var movieTitle: String = ""
    
    var body: some View {
        ZStack {
            Color.main.edgesIgnoringSafeArea(.all)
            
            VStack(spacing: 0) {
                // 커스텀 네비게이션 바
                ZStack {
                    // 뒤로가기 버튼
                    HStack {
                        Button {
                            dismiss()
                        } label: {
                            Image(systemName: "chevron.left")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .semibold))
                                .padding(.top, 8)
                        }
                        Spacer()
                    }
                    
                    // 중앙 타이틀
                    Text("영화 검색")
                        .foregroundStyle(.white)
                        .font(.system(size: 18, weight: .semibold, design: .rounded))
                        .padding(.top, 8)
                }
                .padding(.horizontal)
                
                CustomSearchBar(text: $movieTitle, isLoading: $viewModel.isLoading)
                    .padding(.horizontal)
                    .padding(.top, 20)
                    .onChange(of: movieTitle) { oldValue, newValue in
                        viewModel.debounceSearchMovies(title: newValue)
                    }
                
                Spacer()
            }
        }
        .navigationBarHidden(true)
    }
}

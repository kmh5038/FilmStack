//
//  MovieListView.swift
//  FilmStack
//
//  Created by 김명현 on 10/19/24.
//

import Foundation
import SwiftUI

struct MovieListView: View {
    let movies: [MovieInfoModel]
    
    var body: some View {
        List {
            ForEach(movies, id: \.self) { movie in
                HStack() {
                    Text(movie.boxOfficeInfo.rank ?? "")
                        .font(.system(size: 20, weight: .semibold))
                        .frame(width: 24, alignment: .leading)
                    
                    VStack(alignment: .leading) {
                        if let url = movie.posterURL {
                            AsyncImage(url: url) { image in
                                image.image?.resizable()
                            }
                            .frame(width: 80, height: 100)
                            .cornerRadius(12)
                        }
                    }
                    
                    VStack(alignment: .leading) {
                        Text(movie.boxOfficeInfo.movieNm ?? "")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(.bottom, 10)
                        Text("개봉일자: \(movie.boxOfficeInfo.openDt ?? "")")
                            .font(.system(size: 12, weight: .semibold))
                        Text("누적관객수: \(NumberFormatter.formatNumber(movie.boxOfficeInfo.audiAcc ?? "")) 명")
                            .font(.system(size: 12, weight: .semibold))
                        Text("상영시간: \(movie.runtime ?? "") 분")
                            .font(.system(size: 12, weight: .semibold))
                    }
                    .padding(.horizontal, 10)
                }
            }
        }
        .listStyle(.plain)
    }
}

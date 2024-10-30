//
//  FlimStackView.swift
//  FilmStack
//
//  Created by 김명현 on 10/22/24.
//

import SwiftUI

struct FlimStackView: View {
    @ObservedObject var viewModel: MovieSearchViewModel
    
    var body: some View {
        ZStack {
            Color.main.edgesIgnoringSafeArea(.all)  // 전체 배경을 검은색으로 설정
            
            VStack {
                Text("우측 상단의 + 버튼을 이용하여 영화를 추가해보세요")
                    .foregroundStyle(.gray)
                    .font(.system(size: 14, weight: .semibold))
            }
        }
        .toolbar {
            ToolbarItem(placement: .topBarLeading) {
                Text("필름 스택")
                    .foregroundStyle(.white)
                    .font(.system(size: 20, weight: .bold, design: .rounded))
                    .padding([.bottom, .leading], 10)
            }
            
            ToolbarItem(placement: .topBarTrailing) {
                NavigationLink(destination: MovieSearchView(viewModel: viewModel)) {
                    Image(systemName: "plus")
                        .resizable()
                        .frame(width: 18, height: 18)
                        .foregroundStyle(.white)
                        .fontWeight(.semibold)
                        .padding(.trailing, 10)
                }
            }
        }
    }
}

//#Preview {
//    FlimStackView()
//}

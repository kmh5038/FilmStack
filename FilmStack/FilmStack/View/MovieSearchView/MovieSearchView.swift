//
//  MovieSearchView.swift
//  FilmStack
//
//  Created by 김명현 on 10/22/24.
//

import SwiftUI

struct MovieSearchView: View {
    var body: some View {
        NavigationView {
            ZStack {
                Color.black.edgesIgnoringSafeArea(.all)  // 전체 배경을 검은색으로 설정
                
                VStack {
                    // 여기에 검색 기능과 영화 목록을 추가할 수 있습니다.
                    Text("영화 검색 화면")
                        .foregroundColor(.white)  // 텍스트 색상을 흰색으로 변경
                }
            }
            .navigationTitle("영화 검색")
            .navigationBarTitleDisplayMode(.inline)  // 네비게이션 타이틀을 인라인으로 표시
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        // 버튼 액션
                    }) {
                        Image(systemName: "plus")
                            .font(.title3.bold())
                            .foregroundColor(.white)  // plus 버튼 색상을 흰색으로 변경
                    }
                }
            }
        }
    }
}

#Preview {
    MovieSearchView()
}

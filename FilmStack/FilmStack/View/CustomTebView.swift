//
//  CustomTabView.swift
//  FilmStack
//
//  Created by 김명현 on 10/23/24.
//

import SwiftUI

struct CustomTabView: View {
    @Binding var selectedTab: Int
    let tabs: [(image: String, title: String)]
    
    var body: some View {
        VStack(spacing: 0) {
            Rectangle()
                .fill(Color.gray.opacity(0.3))
                .frame(height: 0.5)

            GeometryReader { geometry in
                HStack(spacing: 0) {
                    ForEach(0..<tabs.count, id: \.self) { index in
                        VStack(spacing: 4) {
                            Spacer()
                                .frame(height: geometry.size.height * 0.3) // 상단 여백 10%
                            
                            Image(systemName: tabs[index].image)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .frame(width: 20, height: 20)
                            
                            Text(tabs[index].title)
                                .font(.system(size: 10))
                            
                            Spacer()
                                .frame(height: geometry.size.height * 0.15) // 하단 여백 15%
                        }
                        .frame(width: geometry.size.width / CGFloat(tabs.count))
                        .foregroundColor(selectedTab == index ? .white : .gray)
                        .onTapGesture {
                            selectedTab = index
                        }
                    }
                }
            }
        }
        .frame(height: 49) // iOS 기본 탭바 높이
        .background(Color.tebView)
    }
}

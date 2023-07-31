//
//  GridView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct GridView: View {
    
    let xLines: Int
    let yLines: Int
    
    private let lineWidth: CGFloat = 1
    
    var body: some View {
        ZStack {
            VStack {
                ForEach(0..<yLines, id: \.self) {
                    createHLine(index: $0)
                }
            }
            HStack {
                ForEach(0..<xLines, id: \.self) {
                    createYLine(index: $0)
                }
            }
        }
        .background(Color(uiColor: .systemGray6))
    }
    
    @ViewBuilder
    private func createYLine(index: Int) -> some View {
        if index == 0 {
            rectangle
                .frame(width: lineWidth)
        } else {
            HStack(spacing: 0) {
                Spacer()
                    .frame(minWidth: 0)
                rectangle
                    .frame(width: lineWidth)
            }
        }
    }
    
    @ViewBuilder
    private func createHLine(index: Int) -> some View {
        if index == 0 {
            rectangle
                .frame(height: lineWidth)
        } else {
            VStack(spacing: 0) {
                Spacer()
                    .frame(minHeight: 0)
                rectangle
                    .frame(height: lineWidth)
            }
        }
    }
    
    private var rectangle: some View {
        Rectangle()
            .fill(.gray)
    }
}

struct GridView_Previews: PreviewProvider {
    static var previews: some View {
        GridView(xLines: 10, yLines: 10)
    }
}


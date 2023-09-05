//
//  CollageView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import SwiftUI

struct CollageView<ViewType: View>: View {
    
    let collage: Collage
    let collageSize: CGSize
    let selectedShapeID: String?
    let intermediateView: ViewType
    
    var isPlaying: Bool
    var strokeColor: UIColor = .green
    var strokeWidth: CGFloat = 7
    
    var onReciveGesture: ((GestureType) -> ())?
    
    var body: some View {
        ZStack {
            ZStack {
                intermediateView
                
                ForEach(collage.texts) {
                    TextItemView(settings: $0,
                                 collageSize: collageSize)
                }
                
                ForEach(collage.shapes) { shape in
                    let isSelected = selectedShapeID == shape.id
                    ShapeItemView(
                        cornerRadius: collage.cornerRadius,
                        shape: shape,
                        size: collageSize,
                        isPlaying: isPlaying,
                        strokeColor: isSelected ? strokeColor : .clear,
                        strokeWidth: strokeWidth
                    )
                }
            }
        }
        .frame(width: collageSize.width,
               height: collageSize.height)
        .background {
            ShapeItemView(
                cornerRadius: 0,
                shape: collage.background,
                size: collageSize,
                isPlaying: isPlaying,
                strokeColor: .clear
            )
        }
        .overlay {
            GestureView() { onReciveGesture?($0) }
        }
    }
    
}

struct CollageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageView(collage: .empty,
                    collageSize: .init(side: 1000),
                    selectedShapeID: nil,
                    intermediateView: EmptyView(),
                    isPlaying: true)
    }
}

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
    let selectedElement: ElementType?
    let intermediateView: ViewType
    
    var isPlaying: Bool
    var strokeColor: UIColor = .green
    var strokeWidth: CGFloat = 3
    
    var onReceiveGesture: ((GestureType) -> ())?
    
    var body: some View {
        ZStack {
            ZStack {
                intermediateView
                
                ForEach(collage.texts) { text in
                    let isSelected = selectedElement?.textId == text.id
                    TextItemView(
                        settings: text,
                        collageSize: collageSize,
                        strokeColor: isSelected ? strokeColor : .clear,
                        strokeWidth: strokeWidth
                    )
                }
                
                ForEach(collage.shapes) { shape in
                    let isSelected = selectedElement?.shapeId == shape.id
                    ShapeItemView(
                        cornerRadius: collage.cornerRadius,
                        shape: shape,
                        size: collageSize,
                        isPlaying: isPlaying,
                        strokeColor: isSelected ? strokeColor : .clear,
                        strokeWidth: strokeWidth * 2
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
                strokeColor: .clear,
                strokeWidth: strokeWidth
            )
        }
        .overlay {
            GestureView() { onReceiveGesture?($0) }
        }
    }
    
}

struct CollageView_Previews: PreviewProvider {
    static var previews: some View {
        CollageView(collage: .empty,
                    collageSize: .init(side: 1000),
                    selectedElement: nil,
                    intermediateView: EmptyView(),
                    isPlaying: true)
    }
}

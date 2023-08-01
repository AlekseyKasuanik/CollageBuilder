//
//  CollageBuiderView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 30.07.2023.
//

import SwiftUI

struct CollageBuiderView: View {
    
    @ObservedObject private(set) var store: AppStore
    
    @State private var collageOffeset: CGPoint = .zero
    @State private var collageScale: CGFloat = 1
    
    var body: some View {
        ZStack {
            GeometryReader { geo in
                ZStack {
                    GridView(xLines: 100, yLines: 100)
                    CollageShape(
                        shape: store.state.shape,
                        size: geo.size
                    )
                    ControlPointsView(
                        controlPoints: store.state.shape.controlPoints,
                        size: geo.size
                    )
                }
            }
        }
        .frame(width: 1000, height: 1000)
        .offset(x: collageOffeset.x,
                y: collageOffeset.y)
        .overlay {
            GestureView() { location in
                
            } onScaleGesture: { scale in
                collageScale = collageScale * scale
            } onTranslateGesture: { translation in
                store.dispatch(.translateConrolPoint(translation))
            } onTwoFingersTranslateGesture: { translation in
                collageOffeset = translation + collageOffeset
            }
        }
        .scaleEffect(collageScale)
        .layoutPriority(-1)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollageBuiderView(store: .preview)
    }
}

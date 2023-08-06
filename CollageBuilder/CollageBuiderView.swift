//
//  CollageBuiderView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 30.07.2023.
//

import SwiftUI

struct CollageBuiderView: View {
    
    private let collageSize: CGSize = .init(side: 1000)
    
    @ObservedObject private(set) var store: AppStore
    
    @State private var collageOffeset: CGPoint = .zero
    @State private var collageScale: CGFloat = 1
    
    @State private var selectedPointsIDs = Set<String>()
    
    private var collage: Collage { store.state.collage }
    
    var body: some View {
        ZStack {
            ZStack {
                ZStack {
                    GridView(xLines: 100, yLines: 100)
                    ForEach(collage.shapes) { shape in
                        CollageShape(
                            shape: shape,
                            size: collageSize
                        )
                    }
                    ControlPointsView(
                        selectedPointsIDs: $selectedPointsIDs,
                        controlPoints: collage.controlPoints,
                        size: collageSize
                    )
                }
            }
            .frame(width: collageSize.width,
                   height: collageSize.height)
            .overlay {
                GestureView() { location in
                    handleLongTap(in: location)
                } onScaleGesture: { scale in
                    collageScale = collageScale * scale
                } onTranslateGesture: { translation in
                    store.dispatch(.translateConrolPoint(translation))
                } onTwoFingersTranslateGesture: { translation in
                    collageOffeset = translation + collageOffeset
                }
            }
            .offset(x: collageOffeset.x * collageSize.width,
                    y: collageOffeset.y * collageSize.height)
            .scaleEffect(collageScale)
            .layoutPriority(-1)
            
            VStack {
                TopBarView()
                HStack {
                    Button {
                        store.dispatch(.conectControlPoints(selectedPointsIDs))
                        selectedPointsIDs.removeAll()
                    } label: {
                        createButtonBody(with: "Conect")
                    }
                    Button {
                        selectedPointsIDs.removeAll()
                    } label: {
                        createButtonBody(with: "Cancel")
                    }
                }
                .buttonStyle(.plain)
                .opacity(selectedPointsIDs.isEmpty ? 0 : 1)
                .animation(.default, value: selectedPointsIDs)
                Spacer()
                AddShapeElementView(size: collageSize)
            }
        }
        .environmentObject(store)

    }
    
    private func createButtonBody(with text: String) -> some View {
        Capsule()
            .fill(Color(uiColor: .systemGray3))
            .frame(width: 100, height: 40)
            .overlay {
                Text(text)
            }
    }
    
    private func handleLongTap(in point: CGPoint) {
        guard let pointID = PointsRecognizer.find(
            point,
            in: collage
        )?.id else {
            return
        }
        
        if selectedPointsIDs.isEmpty,
           let dependencies = collage.dependencies.first(where: {
               $0.pointIDs.contains(pointID)
           }) {
            selectedPointsIDs.formUnion(dependencies.pointIDs)
        }
        
        selectedPointsIDs.update(with: pointID)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollageBuiderView(store: .preview)
    }
}

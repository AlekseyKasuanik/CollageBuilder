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
    
    @State private var showGrid = true
    
    private var collage: Collage { store.state.collage }
    
    var body: some View {
        ZStack {
            collageView
                .overlay {
                    ControlPointsView(
                        selectedPointsIDs: store.state.selectedPointsIDs,
                        controlPoints: collage.controlPoints,
                        size: collageSize
                    )
                }
                .offset(
                    x: store.state.collageSettings.translation.x * collageSize.width,
                    y: store.state.collageSettings.translation.y * collageSize.height
                )
                .scaleEffect(store.state.collageSettings.scale)
                .layoutPriority(-1)
            
            VStack {
                TopBarView()
                DependentPointsConectorView()
                Spacer()
                gridEditor
                editor
            }
        }
        .environmentObject(store)
    }
    
    private var gridEditor: some View {
        HStack {
            Button {
                store.dispatch(.swithEditMode)
            } label: {
                Text(store.state.editMode.rawValue)
            }
            Spacer()
            Button {
                showGrid.toggle()
            } label: {
                Image(systemName: "squareshape.split.3x3")
            }
            .font(.largeTitle)
            .foregroundColor(showGrid ? .red : .blue)
        }
        .padding(.horizontal, 12)
        .frame(height: 50)
    }
    
    private var editor: some View {
        VStack {
            Text(store.state.selectedShapeID == nil
                 ? "Collage Editor"
                 : "ShapeEditor")
            .font(.title2)
            .padding()
            List {
                if store.state.selectedShapeID == nil {
                    AddShapeElementView(size: collageSize)
                    CollageEditorView()
                } else {
                    ShapeEditorView()
                }
            }
            .buttonStyle(.borderless)
        }
        .frame(height: 300)
        .background(Color(uiColor: .systemBackground))
    }
    
    @ViewBuilder
    private var collageView: some View {
        let gridView = GridView(xLines: 100, yLines: 100)
            .opacity(showGrid ? 1 : 0)
        
        CollageView(
            collage: collage,
            collageSize: collageSize,
            selectedShapeID: store.state.selectedShapeID,
            intermediateView: gridView
        ) { store.dispatch(.gesture($0)) }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollageBuiderView(store: .preview)
    }
}

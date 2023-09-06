//
//  CollageBuilderView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 30.07.2023.
//

import SwiftUI

struct CollageBuilderView: View {
    
    @ObservedObject private(set) var store: AppStore
    
    private var collage: Collage { store.state.collage }
    private var collageSize: CGSize { store.state.collageSize }
    
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
        .ignoresSafeArea(.keyboard)
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
                store.dispatch(.togglePlayColalge)
            } label: {
                Image(systemName: store.state.isPlayingCollage
                      ? "pause.circle"
                      : "play.circle")
            }
            .font(.title2)
            Spacer()
            Button {
                store.dispatch(.toggleGrid)
            } label: {
                Image(systemName: "squareshape.split.3x3")
            }
            .font(.largeTitle)
            .foregroundColor(store.state.isShowingGrid ? .red : .blue)
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
            .opacity(store.state.isShowingGrid ? 1 : 0)
        
        CollageView(
            collage: collage,
            collageSize: collageSize,
            selectedShapeID: store.state.selectedShapeID,
            intermediateView: gridView,
            isPlaying: store.state.isPlayingCollage
        ) { store.dispatch(.gesture($0)) }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        CollageBuilderView(store: .preview)
    }
}

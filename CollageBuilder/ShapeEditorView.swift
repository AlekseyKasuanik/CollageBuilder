//
//  ShapeEditorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 17.08.2023.
//

import SwiftUI

struct ShapeEditorView: View {
    
    @EnvironmentObject private var store: AppStore
    
    @State private var showMediaPicker = false
    
    var body: some View {
        Section("Common settings") {
            BlendModeSelectorView(blendMode: .init(
                get: { shape?.blendMode ?? .normal },
                set: { dispatch(.changeBlendMode($0)) }
            ))
            ZPositionSelectorView(zPosition: .init(
                get: { shape?.zPosition ?? 0 },
                set: { dispatch(.changeZPozition($0)) }
            ))
            addMedia
                .sheet(isPresented: $showMediaPicker) {
                    MediaPickerView(media: .init(
                        get: { nil } ,
                        set: { dispatch(.changeMedia($0)) }
                    ))
                }
        }
        Section("Blur") {
            if let shape {
                BlurSelectorView(blur: .init(
                    get: { shape.blur },
                    set: { dispatch(.changeBlur($0)) }
                ))
            }
        }
        Section("Adjustments") {
            if let shape {
                AdjustmentsSelectorView(adjustments: .init(
                    get: { shape.adjustments },
                    set: { dispatch(.changeAdjustments($0)) }
                ))
            }
        }
    }
    
    private var addMedia: some View {
        HStack {
            Text("add media")
            Spacer()
            Button {
                showMediaPicker.toggle()
            } label: {
                Image(systemName: "plus.app")
                    .font(.largeTitle)
            }
        }
    }
    
    private var shape: ShapeData? {
        store.state.collage.shapes.first(where: {
            $0.id == store.state.selectedShapeID ?? ""
        })
    }
    
    private func dispatch(_ action: ShapeModification) {
        guard let id = store.state.selectedShapeID else {
            return
        }
        store.dispatch(.changeCollage(.changeShape(action, id: id)))
    }
}

struct ShapeEditorView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            ShapeEditorView()
                .environmentObject(AppStore.preview)
        }
    }
}


//
//  StickerEditorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 09.09.2023.
//

import SwiftUI
import CoreImage.CIFilterBuiltins

struct StickerEditorView: View {

    @EnvironmentObject private var store: AppStore
    @State private var showMaskEditor = false

    var body: some View {
        Section("mask") {
            Button("Edit mask") {
                showMaskEditor.toggle()
            }
            .frame(maxWidth: .infinity)
        }
        .sheet(isPresented: $showMaskEditor) {
            if let sticker {
                StickerEraserView(sticker: sticker)
                    .presentationBackground(.thinMaterial)
            }
        }
    }
    
    private var sticker: Sticker? {
        let sticker = store.state.collage.stickers.first(where: {
            $0.id == store.state.selectedElement?.stickerId
        })
        
        return sticker
    }
    
    
}

struct StickerEditorView_Previews: PreviewProvider {
    static var previews: some View {
        StickerEditorView()
            .environmentObject(AppStore.preview)
    }
}

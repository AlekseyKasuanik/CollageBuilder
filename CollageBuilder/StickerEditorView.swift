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
            editMask
        }
        Section("manage") {
            remove
        }
        .sheet(isPresented: $showMaskEditor) {
            if let sticker {
                StickerEraserView(sticker: sticker)
                    .presentationBackground(.thinMaterial)
            }
        }
    }
    
    private var editMask: some View {
        HStack {
            Text("Edit mask")
            Spacer()
            Button {
                showMaskEditor.toggle()
            } label: {
                Image(systemName: "paintbrush.pointed.fill")
                    .font(.largeTitle)
            }
        }
    }
    
    private var remove: some View {
        HStack {
            Text("Remove")
            Spacer()
            Button {
                if let sticker {
                    store.dispatch(.changeCollage(
                        .removeSticker(sticker.id)
                    ))
                }
            } label: {
                Image(systemName: "trash.slash")
                    .font(.largeTitle)
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

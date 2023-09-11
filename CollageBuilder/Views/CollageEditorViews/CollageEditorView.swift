//
//  CollageEditorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 16.08.2023.
//

import SwiftUI

struct CollageEditorView: View {
    
    @EnvironmentObject private var store: AppStore
    
    @State private var selectedColor: Color = .clear
    @State private var selectedMedia: Media?
    
    @State private var showMediaPicker = false
    @State private var showTextPicker = false
    @State private var showStickerPicker = false
    
    @State private var cornerRadius: CGFloat = 0
    
    var body: some View {
        Group {
            Section("Background") {
                colorPicker
                mediaPicker
            }
            
            Section("Corner radius") {
                CommonSliderView(value: $cornerRadius,
                                 range: 0...100)
            }
            
            Section("Text") {
                textPicker
            }
            
            Section("Sticker") {
                stickerPicker
            }
        }
        .sheet(isPresented: $showMediaPicker) {
            MediaPickerView(media: $selectedMedia)
        }
        .onChange(of: selectedColor) { color in
            dispatch(.changeBackground(.changeMedia(
                .init(resource: .color(UIColor(color)))
            )))
        }
        .onChange(of: selectedMedia) { media in
            dispatch(.changeBackground(.changeMedia(media)))
        }
        .onChange(of: cornerRadius) { radius in
            dispatch(.changeCornerRadius(radius))
        }
        .onAppear {
            cornerRadius = store.state.collage.cornerRadius
        }
        .sheet(isPresented: $showTextPicker) {
            AddTextView(collageSize: store.state.collageSize,
                        maxZPosition: store.state.collage.maxZPosition)
            .presentationBackground(.thinMaterial)
        }
        .sheet(isPresented: $showStickerPicker) {
            StickerSelectorView(
                maxZPosition: store.state.collage.maxZPosition
            )
            .presentationBackground(.thinMaterial)
        }
    }
    
    private func dispatch(_ modification: CollageModification) {
        store.dispatch(.changeCollage(modification))
    }
    
    private var mediaPicker: some View {
        HStack {
            Text("Select media")
            Spacer()
            Button {
                showMediaPicker.toggle()
            } label: {
                Image(systemName: "photo.circle")
                    .font(.largeTitle)
            }
        }
    }
    
    private var textPicker: some View {
        HStack {
            Text("add text")
            Spacer()
            Button {
                showTextPicker.toggle()
            } label: {
                Image(systemName: "textformat.abc")
                    .font(.title2)
            }
        }
    }
    
    private var stickerPicker: some View {
        HStack {
            Text("add sticker")
            Spacer()
            Button {
                showStickerPicker.toggle()
            } label: {
                Image(systemName: "smiley")
                    .font(.title2)
            }
        }
    }
    
    private var colorPicker: some View {
        ColorPicker(selection: $selectedColor) {
            Text("Select color")
        }
        .padding(.trailing, 5)
    }
}

struct CollageEditorView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            CollageEditorView()
        }
        .environmentObject(AppStore.preview)
    }
}

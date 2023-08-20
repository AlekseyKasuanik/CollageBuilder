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
    @State private var cornerRadius: CGFloat = 0
    
    var body: some View {
        Group {
            Section("Background") {
                colorPicker
                mediaPicker
            }
            Section("Corner radius") {
                cornerRadiusSelector
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
            dispatch(.cnahgeCornerRadius(radius))
        }
        .onAppear {
            cornerRadius = store.state.collage.cornerRadius
        }
    }
    
    private var cornerRadiusSelector: some View {
        HStack {
            Slider(value: $cornerRadius, in: 0...100)
            Text(Int(cornerRadius).description)
                .frame(width: 30)
        }
    }
    
    private func dispatch(_ modifiacion: CollageModification) {
        store.dispatch(.changeCollage(modifiacion))
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

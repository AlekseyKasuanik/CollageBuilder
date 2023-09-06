//
//  AddTextView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 06.09.2023.
//

import SwiftUI

struct AddTextView: View {
    
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) var dismiss
    
    @State private var settings: TextSettings
    
    init(collageSize: CGSize) {
        _settings = State(initialValue: .init(
            collageSize: collageSize,
            text: "",
            fontSize: 15,
            lineSpacing: 1,
            transforms: .init(position: .init(x: 0.5, y: 0.5)),
            zPosition: 10))
    }
    
    var body: some View {
        ZStack {
            TextView(settings: $settings,
                     interactionEnabled: true,
                     keyboardShowed: true)
            .frame(width: settings.size.width,
                   height: settings.size.height)
            topBar
        }
    }
    
    private var topBar: some View {
        VStack {
            HStack {
                Button {
                    dismiss()
                } label: {
                    Text("Cancel")
                }
                Spacer()
                Button {
                } label: {
                    Image(systemName: "")
                    Text("Add Text")
                }
            }
            .padding(20)
            Spacer()
        }
    }
}

struct AddTextView_Previews: PreviewProvider {
    static var previews: some View {
        AddTextView(collageSize: .init(side: 1000))
            .environmentObject(AppStore.preview)
    }
}

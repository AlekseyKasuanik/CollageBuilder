//
//  TextSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextSelectorView: View {
    
    @EnvironmentObject private var store: AppStore
    
    @State private var showFontSelector = false
    @State private var showTextEditor = false
    
    var body: some View {
        if let text {
            textEditor
                .sheet(isPresented: $showTextEditor) {
                    TextEditorView(text: .init(
                        get: { text },
                        set: { dispatch(.text($0.text))}
                    ))
                    .presentationBackground(.thinMaterial)
                }
            Section("Font") {
                createFontEditor(for: text)
                .sheet(isPresented: $showFontSelector) {
                    FontSelectorView()
                }
            }
            
            Section("Paragraph") {
                createParagraphEditor(for: text)
            }
            
            Section("Appearance") {
                createAppearanceEditor(for: text)
            }
        } else {
            EmptyView()
        }
    }
    
    private var textEditor: some View {
        Button("Change Text") {
            showTextEditor.toggle()
        }
        .frame(maxWidth: .infinity)
    }
    
    private func createAppearanceEditor(for text: TextSettings) -> some View {
        VStack(spacing: 16) {
            ColorPicker(selection: .init(
                get: { Color(text.backgroundColor) },
                set: { dispatch(.backgroundColor(UIColor($0)))}
            )) {
                Text("Background color")
            }
            CommonSliderView(
                value: .init(
                    get: { text.cornerRadius },
                    set: { dispatch(.cornerRadius($0)) }
                ),
                range: 0...50,
                title: "Corner radius"
            )
            .padding(.trailing, 5)
            
            BlendModeSelectorView(blendMode: .init(
                get: { text.blendMode },
                set: { dispatch(.blendMode($0)) }
            ))
        }
    }
    
    private func createParagraphEditor(for text: TextSettings) -> some View {
        VStack(spacing: 16) {
            CommonSliderView(
                value: .init(
                    get: { text.kern },
                    set: { dispatch(.kern($0)) }
                ),
                range: 0...20,
                title: "Kent"
            )
            
            CommonSliderView(
                value: .init(
                    get: { text.lineSpacing },
                    set: { dispatch(.lineSpacing($0)) }
                ),
                range: 0...100,
                title: "Line spacing"
            )
            HStack {
                Text("Alignment")
                Spacer()
                Picker(
                    "",
                    selection: .init(
                        get: { text.alignment },
                        set: { dispatch(.alignment($0)) }
                    )
                ) {
                    ForEach(TextSettings.TextAlignment.allCases, id: \.self) {
                        Text($0.rawValue)
                    }
                }
            }
        }
    }
    
    private func createFontEditor(for text: TextSettings) -> some View {
        VStack(spacing: 16) {
            CommonSliderView(
                value: .init(
                    get: { text.fontSize },
                    set: { dispatch(.size($0)) }
                ),
                range: 10...100,
                title: "Size"
            )
            
            HStack {
                Text("Name")
                Spacer()
                Button {
                    showFontSelector.toggle()
                } label: {
                    Text(text.fontName)
                        .font(.custom(text.fontName, size: 14))
                }
            }
            
            ColorPicker(selection: .init(
                get: { Color(text.textColor) },
                set: { dispatch(.textColor(UIColor($0)))}
            )) {
                Text("Text color")
            }
            .padding(.trailing, 5)
        }
    }
    
    private var text: TextSettings? {
        let text = store.state.collage.texts.first(where: {
            $0.id == store.state.selectedElement?.textId
        })
        
        return text
    }
    
    private func dispatch(_ action: TextModification) {
        guard let id = store.state.selectedElement?.textId else {
            return
        }
        
        store.dispatch(.changeCollage(.changeText(action, id: id)))
    }
}

struct TextSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        List {
            TextSelectorView()
                .environmentObject(AppStore.preview)
        }
    }
}


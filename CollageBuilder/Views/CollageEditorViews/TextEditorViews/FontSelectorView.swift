//
//  FontSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import SwiftUI

struct FontSelectorView: View {
    
    @EnvironmentObject private var store: AppStore
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Button("Close") {
                    dismiss()
                }
            }
            .padding()
            List {
                ForEach(allFonts, id: \.self) { name in
                    Button {
                        dismiss()
                        dispatch(.changeFontName(name))
                    } label: {
                        Text(name)
                            .font(.custom(name, size: 14))
                    }
                    .foregroundColor(Color(UIColor.label))
                }
            }
        }
    }
    
    private func dispatch(_ action: TextModification) {
        guard let id = store.state.selectedElement?.textId else {
            return
        }
        
        store.dispatch(.changeCollage(.changeText(action, id: id)))
    }
    
    var allFonts: [String] {
        UIFont.familyNames.flatMap {
            UIFont.fontNames(forFamilyName: $0)
        }
    }
}

struct FontSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        FontSelectorView()
    }
}

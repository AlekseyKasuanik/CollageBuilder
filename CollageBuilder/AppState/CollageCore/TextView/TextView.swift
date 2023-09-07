//
//  TextView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var settings: TextSettings
    var interactionEnabled: Bool = false
    var keyboardShowed: Bool = false
    
    func makeUIView(context: Context) -> TextUIView {
        
        let view = TextUIView(settings: $settings)
        view.changeSettings(settings)
        view.isUserInteractionEnabled = interactionEnabled
        
        return view
    }
    
    func updateUIView(_ uiView: TextUIView, context: Context) {
        uiView.changeSettings(settings)
        uiView.isUserInteractionEnabled = interactionEnabled
        keyboardShowed
        ? uiView.showKeyboard()
        : uiView.hideKeyboard()
    }
}

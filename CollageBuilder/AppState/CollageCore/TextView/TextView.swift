//
//  TextView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextView: UIViewRepresentable {
    
    @Binding var settings: TextSettings
    
    func makeUIView(context: Context) -> TextUIView {
        
        let view = TextUIView(settings: $settings)
        view.changeSettings(settings)
        
        return view
    }
    
    func updateUIView(_ uiView: TextUIView, context: Context) {
        uiView.changeSettings(settings)
    }
}

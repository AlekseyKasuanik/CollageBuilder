//
//  GestureView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct GestureView: UIViewRepresentable {
    
    var onRecive: ((GestureType) -> ())?
    
    func makeUIView(context: Context) -> UIView {
        
        let view = GestureUIView()
        view.onRecive = onRecive
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

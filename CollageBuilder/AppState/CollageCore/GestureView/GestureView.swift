//
//  GestureView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct GestureView: UIViewRepresentable {
    
    var onReceive: ((GestureType) -> ())?
    
    func makeUIView(context: Context) -> UIView {
        
        let view = GestureUIView()
        view.onReceive = onReceive
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

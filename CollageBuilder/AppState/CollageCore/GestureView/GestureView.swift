//
//  GestureView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct GestureView: UIViewRepresentable {
    
    var onTapGesture: ((CGPoint) -> ())?
    var onLongTapGesture: ((CGPoint) -> ())?
    var onScaleGesture: ((CGFloat) -> ())?
    var onTranslateGesture: ((GestureState) -> ())?
    var onTwoFingersTranslateGesture: ((CGPoint) -> ())?
    
    func makeUIView(context: Context) -> UIView {
        
        let view = GestureUIView()
        
        view.onTapGesture = onTapGesture
        view.onLongTapGesture = onLongTapGesture
        view.onScaleGesture = onScaleGesture
        view.onTranslateGesture = onTranslateGesture
        view.onTwoFingersTranslateGesture = onTwoFingersTranslateGesture
        
        return view
    }
    
    func updateUIView(_ uiView: UIView, context: Context) {}
}

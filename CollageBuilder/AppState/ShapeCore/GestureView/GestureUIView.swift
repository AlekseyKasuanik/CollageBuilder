//
//  GestureUIView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

final class GestureUIView: UIView {
    
    var onTapGesture: ((CGPoint) -> ())?
    var onScaleGesture: ((CGFloat) -> ())?
    var onTranslateGesture: ((GestureState) -> ())?
    var onTwoFingersTranslateGesture: ((CGPoint) -> ())?
    
    private var lastScale: CGFloat?
    
    init() {
        super.init(frame: .zero)
        setupGestures()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupGestures() {
        let pinchGesture = UIPinchGestureRecognizer(
            target: self,
            action: #selector(pinchGestureRecognizer)
        )
        addGestureRecognizer(pinchGesture)
        
        let tapGesture = UITapGestureRecognizer(
            target: self,
            action: #selector(tapGestureRecognizer)
        )
        addGestureRecognizer(tapGesture)
        
        let panGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(panGestureRecognizer)
        )
        addGestureRecognizer(panGesture)
        
        let twoFingersPanGesture = UIPanGestureRecognizer(
            target: self,
            action: #selector(twoFingersPanGestureRecognizer)
        )
        twoFingersPanGesture.minimumNumberOfTouches = 2
        addGestureRecognizer(twoFingersPanGesture)
        
    }
    
    @objc private func panGestureRecognizer(gesture: UIPanGestureRecognizer)  {
        
        switch gesture.state {
        case .began:
            onTranslateGesture?(.began(
                position: gesture.location(in: self)
            ))
            
        case .changed:
            onTranslateGesture?(.changed(
                translation: gesture.translation(in: self)
            ))
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc private func twoFingersPanGestureRecognizer(gesture: UIPanGestureRecognizer) {
        onTwoFingersTranslateGesture?(gesture.translation(in: self))
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc private func pinchGestureRecognizer(gesture: UIPinchGestureRecognizer) {
        
        if let lastScale {
            onScaleGesture?(gesture.scale / lastScale)
        }
        
        switch gesture.state {
        case .began, .changed:
            lastScale = gesture.scale
            
        case .ended:
            self.lastScale = nil
            
        default:
            return
        }
    }
    
    @objc private func tapGestureRecognizer(gesture: UITapGestureRecognizer) {
        onTapGesture?(gesture.location(in: self))
    }
    
}

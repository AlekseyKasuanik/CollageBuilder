//
//  GestureUIView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

final class GestureUIView: UIView {
    
    var onTapGesture: ((CGPoint) -> ())?
    var onLongTapGesture: ((CGPoint) -> ())?
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
        
        let longTapGesture = UILongPressGestureRecognizer(
            target: self,
            action: #selector(longTapGestureRecognizer)
        )
        addGestureRecognizer(longTapGesture)
        
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
            let location = gesture.location(in: self)
            onTranslateGesture?(.began(
                position: CGPoint(
                    x: location.x / frame.width,
                    y: location.y / frame.height
                )
            ))
            
        case .changed:
            let translation = gesture.translation(in: self)
            onTranslateGesture?(.changed(
                translation: CGPoint(
                    x: translation.x / frame.width,
                    y: translation.y / frame.height
                )
            ))
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc private func twoFingersPanGestureRecognizer(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: self)
        onTwoFingersTranslateGesture?(CGPoint(
            x: translation.x / frame.width,
            y: translation.y / frame.height
        ))
        
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
    
    @objc private func longTapGestureRecognizer(gesture: UILongPressGestureRecognizer) {
        guard gesture.state == .began else { return }
        
        let location = gesture.location(in: self)
        onLongTapGesture?(CGPoint(
            x: location.x / frame.width,
            y: location.y / frame.height
        ))
        
    }
    
    @objc private func tapGestureRecognizer(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        onTapGesture?(CGPoint(
            x: location.x / frame.width,
            y: location.y / frame.height
        ))
    }
    
}

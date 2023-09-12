//
//  GestureUIView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

final class GestureUIView: UIView {
    
    var onReceive: ((GestureType) -> ())?
    
    private var lastScale: CGFloat?
    private var lastRotation: CGFloat?
    
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
        
        let rotateGesture = UIRotationGestureRecognizer(
            target: self,
            action: #selector(rotateGestureRecognizer)
        )
        addGestureRecognizer(rotateGesture)
        
    }
    
    @objc private func panGestureRecognizer(gesture: UIPanGestureRecognizer)  {
        
        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            onReceive?(.translate(.began(CGPoint(
                x: location.x / frame.width,
                y: location.y / frame.height
            ))))
            
        case .changed:
            let translation = gesture.translation(in: self)
            onReceive?(.translate(.changed(CGPoint(
                x: translation.x / frame.width,
                y: translation.y / frame.height
            ))))
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc private func twoFingersPanGestureRecognizer(gesture: UIPanGestureRecognizer) {

        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            onReceive?(.twoFingersTranslate(.began(CGPoint(
                x: location.x / frame.width,
                y: location.y / frame.height
            ))))
            
        case .changed:
            let translation = gesture.translation(in: self)
            onReceive?(.twoFingersTranslate(.changed(CGPoint(
                x: translation.x / frame.width,
                y: translation.y / frame.height
            ))))
            
        default:
            break
        }
        
        gesture.setTranslation(.zero, in: self)
    }
    
    @objc private func pinchGestureRecognizer(gesture: UIPinchGestureRecognizer) {
        
        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            onReceive?(.scale(.began(CGPoint(
                x: location.x / frame.width,
                y: location.y / frame.height
            ))))
            
            lastScale = gesture.scale
            
        case .changed:
            if let lastScale {
                onReceive?(.scale(.changed(gesture.scale / lastScale)))
            }
            
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
        onReceive?(.longTap(CGPoint(
            x: location.x / frame.width,
            y: location.y / frame.height
        )))
        
    }
    
    @objc private func tapGestureRecognizer(gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: self)
        onReceive?(.tap(CGPoint(
            x: location.x / frame.width,
            y: location.y / frame.height
        )))
    }
    
    @objc private func rotateGestureRecognizer(gesture: UIRotationGestureRecognizer) {
        switch gesture.state {
        case .began:
            let location = gesture.location(in: self)
            onReceive?(.rotate(.began(CGPoint(
                x: location.x / frame.width,
                y: location.y / frame.height
            ))))
            
            lastRotation = gesture.rotation
            
        case .changed:
            if let lastRotation {
                onReceive?(.rotate(.changed(gesture.rotation - lastRotation)))
            }
            
            lastRotation = gesture.rotation
        default:
            break
        }
    }
    
}

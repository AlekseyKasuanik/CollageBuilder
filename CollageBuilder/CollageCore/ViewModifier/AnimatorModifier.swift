//
//  AnimatorModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.09.2023.
//

import SwiftUI

struct AnimatorModifier: ViewModifier {
    
    var animate = false
    var animation: AnimationSettings
    
    @State private var size: CGSize = .zero
    @State private var rotation: CGFloat = 0
    @State private var offset: CGPoint = .zero
    @State private var opacity: CGFloat = 1
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .onAppear { size = geo.size }
                        .onChange(of: geo.size) { size = $0 }
                }
            }
            .opacity(opacity)
            .rotationEffect(.radians(rotation))
            .offset(x: offset.x * size.width,
                    y: offset.y * size.height)
            .animation(createAnimation(for: animation.rotation), value: rotation)
            .animation(createAnimation(for: animation.opacity), value: opacity)
            .animation(createAnimation(for: animation.offset), value: offset)
            .onChange(of: animate) { animate in
                if let targetOpacity = animation.opacity?.value {
                    opacity = animate ? targetOpacity : 1
                }
                Task {
                    if let targetOffset = animation.offset?.value {
                        offset = animate ? targetOffset : .zero
                    }
                    Task {
                        if let targetRotation = animation.rotation?.value {
                            rotation = animate ? targetRotation: 0
                        }
                    }
                }
            }
    }
    
    var offsetAnimation: Animation? {
        guard let animation = animation.offset else {
            return nil
        }
        
        return .curve(type: animation.animation,
                      duration: animation.duration)
        .delay(animation.delay)
        .repeatWhile(
            animate,
            autoreverses: animation.autoreverses
        )
    }
    
    private func createAnimation<T>(for: AnimationSettings.AnimationValue<T>?) -> Animation? {
        guard let animation = animation.offset else {
            return nil
        }
        
        return .curve(type: animation.animation,
                      duration: animation.duration)
        .delay(animation.delay)
        .repeatWhile(
            animate,
            autoreverses: animation.autoreverses
        )
    }
    
}

extension View {
    func contentAnimation(animate: Bool, animation: AnimationSettings) -> some View {
        modifier(AnimatorModifier(animate: animate, animation: animation))
    }
}

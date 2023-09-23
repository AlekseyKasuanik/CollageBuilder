//
//  AnimatorModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 21.09.2023.
//

import SwiftUI

fileprivate struct AnimatorModifier: ViewModifier {
    
    var animate: Bool
    var animation: AnimationSettings?
    
    @State private var size: CGSize = .zero
    @State private var settings = AnimationFrameSettings()
    @State private var animationProgress: Double = 0
    @State private var inAnimation = false
    
    func body(content: Content) -> some View {
        content
            .overlay {
                GeometryReader { geo in
                    Color.clear
                        .onAppear { size = geo.size }
                        .onChange(of: geo.size) { size = $0 }
                }
            }
            .opacity(settings.alpha)
            .rotationEffect(.radians(settings.rotation))
            .scaleEffect(settings.scale)
            .offset(x: settings.translation.x * size.width,
                    y: settings.translation.y * size.height)
            .frameAnimator(observedValue: animationProgress,
                           animation: animation,
                           settings: $settings)
            .onAnimationCompleted(for: animationProgress) {
                inAnimation = false
                setupAnimation(animate)
            }
            .onChange(of: animate) { setupAnimation($0) }
    }
    
    func setupAnimation(_ animate: Bool) {
        guard let animation,
              animate,
              !inAnimation else {
            settings = AnimationFrameSettings()
            return
        }
        
        inAnimation = true
        animationProgress = 0
        withAnimation(.linear(duration: animation.duration)) {
            animationProgress = 1
        }
    }
}

extension View {
    func frameAnimation(animate: Bool,
                        animation: AnimationSettings?) -> some View {
        
        self.modifier(AnimatorModifier(animate: animate,
                                       animation: animation))
    }
}

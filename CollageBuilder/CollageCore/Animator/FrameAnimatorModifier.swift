//
//  FrameAnimatorModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 21.09.2023.
//

import SwiftUI

fileprivate struct FrameAnimatorModifier: AnimatableModifier {
    
    @Binding var settings: AnimationFrameSettings
    
    var animation: AnimationSettings?
    var animatableData: Double {
        didSet { notifyProgress() }
    }
    
    func body(content: Content) -> some View {
        content
    }
    
    private func notifyProgress() {
        guard animatableData >= 0,
              animatableData <= 1,
              let animation else {
            return
        }
        
        DispatchQueue.main.async {
            print(animatableData)
            let frame = Int(animatableData * (Double(animation.frames.count) - 1))
            settings = animation.frames[frame]
        }
    }
}

extension View {
    func frameAnimator(observedValue: Double,
                       animation: AnimationSettings?,
                       settings: Binding<AnimationFrameSettings>) -> some View {
        self.modifier(FrameAnimatorModifier(settings: settings,
                                            animation: animation,
                                            animatableData: observedValue))
    }
}

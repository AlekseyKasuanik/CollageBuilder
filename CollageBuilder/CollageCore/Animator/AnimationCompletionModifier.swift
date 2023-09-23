//
//  AnimationCompletionModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 21.09.2023.
//

import SwiftUI

struct AnimationCompletionModifier<Value: VectorArithmetic>: AnimatableModifier {

    var animatableData: Value {
        didSet { notifyCompletionIfFinished() }
    }

    private var targetValue: Value
    private var completion: () -> Void

    init(observedValue: Value,
         completion: @escaping () -> Void) {
        
        self.completion = completion
        self.animatableData = observedValue
        targetValue = observedValue
    }

    private func notifyCompletionIfFinished() {
        guard animatableData == targetValue else { return }
        DispatchQueue.main.async {
            self.completion()
        }
    }

    func body(content: Content) -> some View {
        content
    }
}

extension View {
    func onAnimationCompleted<Value: VectorArithmetic>(for value: Value,
                                                       completion: @escaping () -> Void) -> some View {
        
        modifier(AnimationCompletionModifier(observedValue: value, completion: completion))
    }
}

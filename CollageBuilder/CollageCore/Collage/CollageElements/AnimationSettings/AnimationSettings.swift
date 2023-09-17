//
//  AnimationSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 17.09.2023.
//

import Foundation

struct AnimationSettings {
    let offset: AnimationValue<CGPoint>
    let rotation: AnimationValue<CGFloat>
    let opacity: AnimationValue<CGFloat>
    
    struct AnimationValue<Value> {
        let value: Value
        let duration: CGFloat
        let delay: CGFloat
        let autoreverses: Bool
        let animation: CurveType
    }
}

//
//  AnimationSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 17.09.2023.
//

import Foundation

struct AnimationSettings: Codable {
    private(set) var id = UUID().uuidString
    
    var offset: AnimationValue<CGPoint>?
    var rotation: AnimationValue<CGFloat>?
    var opacity: AnimationValue<CGFloat>?
    
    struct AnimationValue<Value: Codable>: Codable {
        var value: Value
        var duration: CGFloat = 0.35
        var delay: CGFloat = 0
        var autoreverses: Bool = true
        var animation: CurveType = .easeInOut
    }
}

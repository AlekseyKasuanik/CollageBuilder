//
//  AnimationFrameSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.09.2023.
//

import Foundation

struct AnimationFrameSettings: Codable {
    var alpha: CGFloat = 1
    var translation: CGPoint = .zero
    var rotation: CGFloat = 0
    var scale: CGFloat = 1
}

//
//  AnimationSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.09.2023.
//

import Foundation

struct AnimationSettings: Codable {
    private(set) var id = UUID().uuidString
    
    let frameRate: Int
    let frames: [AnimationFrameSettings]
    
    var duration: Double { Double(frames.count) / Double(frameRate) }
}

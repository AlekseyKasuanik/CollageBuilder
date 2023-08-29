//
//  VideoSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 10.08.2023.
//

import Foundation

struct VideoSettings: Codable {
    
    var trim: VideoTrim?
    var speed: Float
    var isMuted: Bool
    
    static let defaultSettings = VideoSettings(speed: 1, isMuted: true)
    
}

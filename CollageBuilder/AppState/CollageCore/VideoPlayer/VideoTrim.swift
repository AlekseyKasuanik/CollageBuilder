//
//  VideoTrim.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 10.08.2023.
//

import AVFoundation

struct VideoTrim: Codable, Equatable {
    
    var start: CGFloat
    var end: CGFloat
    var timescale: CMTimeScale = 600
    
    var startTime: CMTime {
        .init(seconds: start, preferredTimescale: timescale)
    }
    
    var endTime: CMTime {
        .init(seconds: end, preferredTimescale: timescale)
    }
    
}


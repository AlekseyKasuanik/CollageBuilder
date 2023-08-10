//
//  VideoTrim.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 10.08.2023.
//

import AVFoundation

struct VideoTrim {
    var startTime: CMTime
    var endTime: CMTime
}

extension VideoTrim {
    init(start: CGFloat,
         end: CGFloat,
         timescale: CMTimeScale = 600) {
        
        self.init(
            startTime: .init(seconds: start, preferredTimescale: timescale),
            endTime: .init(seconds: end, preferredTimescale: timescale)
        )
    }
}

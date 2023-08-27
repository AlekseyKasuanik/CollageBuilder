//
//  MediaTransforms.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 26.08.2023.
//

import Foundation

struct MediaTransforms: Codable, Equatable {
    var scale: CGFloat
    var translation: CGPoint
    var rotaion: CGFloat
    
    static var defaultTransforms: MediaTransforms {
        .init(scale: 1,
              translation: .zero,
              rotaion: 0)
    }
}

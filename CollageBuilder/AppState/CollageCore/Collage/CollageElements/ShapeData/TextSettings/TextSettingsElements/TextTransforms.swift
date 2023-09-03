//
//  TextTransforms.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import Foundation

struct TextTransforms: Codable {
    var scale: CGFloat
    var position: CGPoint
    var rotation: CGFloat
    
    static var defaultTransforms: TextTransforms {
        .init(scale: 1,
              position: .init(x: 0.5, y: 0.5),
              rotation: 0)
    }
}

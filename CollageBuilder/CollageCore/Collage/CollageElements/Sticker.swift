//
//  Sticker.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import SwiftUI

struct Sticker: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    
    var transforms: Transforms = .init(position: .init(x: 0.5, y: 0.5))
    var relativeInitialSize: CGSize = .init(side: 0.2)
    var blendMode: ContentBlendMode = .normal
    var zPosition: Int 
    
    @CodableWrapper var image: UIImage
    @CodableWrapper var mask: UIImage?
    
    var normalizedRect: CGRect {
        CGRect(size: relativeInitialSize,
               around: transforms.position)
    }
}

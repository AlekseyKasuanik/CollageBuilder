//
//  TextSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextSettings: Codable, Identifiable {
    private(set) var id = UUID().uuidString
    private(set) var collageSize: CGSize
    
    var boundsSpacing: CGFloat = 15
    var text: String
    var fontSize: CGFloat
    var lineSpacing: CGFloat
    var transforms: Transforms
    var zPosition: Int
    
    var attributedString: NSMutableAttributedString {
        AttributedStringCreator.create(from: self)
    }
    
    var size: CGSize {
        let size = attributedString.size()
        
        return .init(width: size.width + boundsSpacing,
                     height: size.height + boundsSpacing)
    }
    
    var normalizedRect: CGRect {
        let normalizedSize = CGSize(
            width: size.width / collageSize.width,
            height: size.height / collageSize.height
        )
        
        return .init(size: normalizedSize,
                     around: transforms.position)
    }
    
}

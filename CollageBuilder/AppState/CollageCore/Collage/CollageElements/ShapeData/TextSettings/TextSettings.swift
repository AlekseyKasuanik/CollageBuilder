//
//  TextSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextSettings: Codable {
    var text: String
    var fontSize: CGFloat
    var lineSpacing: CGFloat
    var transforms: TextTransforms
    
    var attributedString: NSMutableAttributedString {
        AttributedStringCreator.create(from: self)
    }
    
    var size: CGSize {
        attributedString.size()
    }
}

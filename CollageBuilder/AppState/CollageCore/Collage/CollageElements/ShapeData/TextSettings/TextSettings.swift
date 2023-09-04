//
//  TextSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextSettings: Codable {
    private(set) var id = UUID().uuidString
    
    var text: String
    var fontSize: CGFloat
    var lineSpacing: CGFloat
    var transforms: Transforms
    var zPosition: Int
    
    var attributedString: NSMutableAttributedString {
        AttributedStringCreator.create(from: self)
    }
    
    var rect: CGRect {
        .init(size: attributedString.size(),
              around: transforms.position)
    }
    
}

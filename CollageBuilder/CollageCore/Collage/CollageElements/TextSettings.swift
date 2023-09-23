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
    
    var zPosition: Int
    
    var boundsSpacing: CGFloat = 15
    var text: String = ""
    var fontSize: CGFloat = 20
    var fontName: String = UIFont.systemFont(ofSize: 20).fontName
    var lineSpacing: CGFloat = 0
    var kern: CGFloat = 0
    var alignment: TextAlignment = .center
    var transforms: Transforms = .init(position: .init(x: 0.5, y: 0.5))
    var cornerRadius: CGFloat = 5
    var blendMode: ContentBlendMode = .normal
    var animation: AnimationSettings?
    
    @CodableWrapper var textColor: UIColor = .black
    @CodableWrapper var backgroundColor: UIColor = .clear
    
    var attributedString: NSMutableAttributedString {
        AttributedStringCreator.create(from: self)
    }
    
    var font: UIFont {
        UIFont(name: fontName, size: fontSize) ??
        UIFont.systemFont(ofSize: fontSize)
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
    
    enum TextAlignment: String, Codable, CaseIterable {
        case left, right, center
    }
}


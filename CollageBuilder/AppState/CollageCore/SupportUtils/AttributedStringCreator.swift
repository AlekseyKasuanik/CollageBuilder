//
//  AttributedStringCreator.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

enum AttributedStringCreator {
    
    static func create(from settings: TextSettings) -> NSMutableAttributedString {
        let attributedString = NSMutableAttributedString(string: settings.text)
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = settings.lineSpacing
        paragraphStyle.alignment = .init(textAlignment: settings.alignment)
 

        attributedString.addAttributes(
            [.font : settings.font,
             .paragraphStyle : paragraphStyle,
             .kern : settings.kern,
             .foregroundColor : settings.textColor
            ],
            range: NSMakeRange(0, attributedString.length)
        )
        
        return attributedString
    }
}

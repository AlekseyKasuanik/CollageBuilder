//
//  TextModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import SwiftUI

enum TextModification {
    case size(CGFloat)
    case fontName(String)
    case kern(CGFloat)
    case lineSpacing(CGFloat)
    case alignment(TextSettings.TextAlignment)
    case text(String)
    case textColor(UIColor)
    case backgroundColor(UIColor)
    case cornerRadius(CGFloat)
    case blendMode(ContentBlendMode)
}

//
//  TextModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import SwiftUI

enum TextModification {
    case changeSize(CGFloat)
    case changeFontName(String)
    case changeKern(CGFloat)
    case changeLineSpacing(CGFloat)
    case changeAlignment(TextSettings.TextAlignment)
    case changeText(String)
    case changeTextColor(UIColor)
    case changeBackgroundColor(UIColor)
    case changeCornerRadius(CGFloat)
    case changeBlendMode(ContentBlendMode)
}

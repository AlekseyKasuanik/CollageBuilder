//
//  CollageModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

enum CollageModification {
    case changeBackground(ShapeModification)
    case connectControlPoints(Set<String>)
    case disconnectControlPoints(Set<String>)
    case changeCornerRadius(CGFloat)
    case addShape(ShapeData)
    case changeShape(ShapeModification, id: String)
    case removeShape(String)
    case addText(TextSettings)
    case changeText(TextModification, id: String)
    case removeText(String)
    case addSticker(Sticker)
    case changeSticker(StickerModification, id: String)
    case removeSticker(String)
}

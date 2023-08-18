//
//  ShapeModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import Foundation

enum ShapeModification {
    case addElement(ShapeElement)
    case changeMedia(Media?)
    case changeBlendMode(ContentBlendMode)
    case changeZPozition(Int)
}

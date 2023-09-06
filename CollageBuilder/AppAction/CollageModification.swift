//
//  CollageModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

enum CollageModification {
    case addShape(ShapeData)
    case changeBackground(ShapeModification)
    case conectControlPoints(Set<String>)
    case disconectControlPoints(Set<String>)
    case changeCornerRadius(CGFloat)
    case changeShape(ShapeModification, id: String)
}

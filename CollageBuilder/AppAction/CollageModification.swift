//
//  CollageModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

enum CollageModification {
    case addShape(ShapeData)
    case changeBackground(CollageBackground)
    case conectControlPoints(Set<String>)
}

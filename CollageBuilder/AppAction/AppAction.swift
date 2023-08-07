//
//  AppAction.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum AppAction {
    case translateConrolPoint(GestureState)
    case conectControlPoints(Set<String>)
    case addShape(ShapeData)
    case addElement(ShapeElement, shapeId: String)
    case setCollage(Collage)
    case changeMedia(Media?, shapeId: String)
}

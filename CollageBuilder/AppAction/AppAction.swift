//
//  AppAction.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum AppAction {
    case translate(GestureState)
    case addElement(ShapeElement, shapeId: String)
    case setCollage(Collage)
    case changeMedia(Media?, shapeId: String)
    case changeCollage(CollageModification)
}

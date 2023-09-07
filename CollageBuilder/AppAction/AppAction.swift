//
//  AppAction.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum AppAction {
    case gesture(GestureType)
    case setCollage(Collage)
    case changeCollage(CollageModification)
    case selectElement(ElementType)
    case removeSelectedPoints
    case swithEditMode
    case toggleGrid
    case togglePlayColalge
}

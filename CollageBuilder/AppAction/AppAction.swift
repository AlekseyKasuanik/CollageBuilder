//
//  AppAction.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum AppAction {
    case translate(GestureState)
    case setCollage(Collage)
    case changeCollage(CollageModification)
    case selectShape(String?)
}

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
}

//
//  GestureAction.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import Foundation

enum GestureAction {
    case tap(CGPoint)
    case longTap(CGPoint)
    case scale(CGFloat)
    case translate(GestureState)
    case twoFingersTranslate(CGPoint)
}

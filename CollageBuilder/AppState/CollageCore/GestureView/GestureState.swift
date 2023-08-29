//
//  GestureState.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum GestureType {
    case tap(CGPoint)
    case longTap(CGPoint)
    case scale(GestureState<CGFloat>)
    case translate(GestureState<CGPoint>)
    case twoFingersTranslate(GestureState<CGPoint>)
    case rotate(GestureState<CGFloat>)
    
    enum GestureState<T> {
        case began(CGPoint)
        case changed(T)
    }
}

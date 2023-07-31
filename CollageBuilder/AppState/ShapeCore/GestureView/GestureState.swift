//
//  GestureState.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum GestureState {
    case began(position: CGPoint)
    case changed(translation: CGPoint)
}

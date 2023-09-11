//
//  ElementsTransformerProtocol.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 11.09.2023.
//

import Foundation

protocol ElementsTransformerProtocol {
    mutating func translate(_ gestureState: GestureType.GestureState<CGPoint>,
                            in collage: Collage) -> Collage
    
    mutating func scale(_ gestureState: GestureType.GestureState<CGFloat>,
                        in collage: Collage) -> Collage
    
    mutating func rotate(_ gestureState: GestureType.GestureState<CGFloat>,
                         in collage: Collage) -> Collage
}

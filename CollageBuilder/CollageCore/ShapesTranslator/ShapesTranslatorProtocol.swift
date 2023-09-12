//
//  ShapesTranslatorProtocol.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 11.09.2023.
//

import Foundation

protocol ShapesTranslatorProtocol {
    mutating func translate(_ translation: GestureType.GestureState<CGPoint>,
                            in collage: Collage) -> Collage
}

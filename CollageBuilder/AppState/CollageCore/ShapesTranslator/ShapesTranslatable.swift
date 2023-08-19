//
//  ShapesTranslatable.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import Foundation

protocol ShapesTranslatable {
    mutating func translate(_ translation: GestureState,
                            in collage: Collage) -> Collage
}

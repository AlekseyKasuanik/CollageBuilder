//
//  ShapeData.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct ShapeData: Identifiable, Codable {
    var elements: [ShapeElement]
    var media: Media?
    var zPosition: Int
    var blendMode: ContentBlendMode
    var blur: Blur
    var adjustments: Adjustments
    var transforms: Transforms
    var filter: ColorFilter?
    
    private(set) var id: String = UUID().uuidString
    
    var controlPoints: [ControlPoint] {
        ControlPointsExtractor.extract(from: self)
    }
    
    var fitRect: CGRect {
        RectExtractor.extract(from: self)
    }
}

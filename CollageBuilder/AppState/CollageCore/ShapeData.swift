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
    
    private(set) var id: String = UUID().uuidString
    
    var controlPoints: [ControlPoint] {
        ControlPointsExtractor.extract(from: self)
    }
    
    var fitRect: CGRect {
        RectExtractor.extract(from: self)
    }
}


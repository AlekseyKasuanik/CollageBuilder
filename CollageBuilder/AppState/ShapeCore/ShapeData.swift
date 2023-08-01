//
//  ShapeData.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct ShapeData {
    var elements: [ShapeElement]
    
    private(set) var id: String = UUID().uuidString
    
    var controlPoints: [ControlPoint] {
        ControlPointsExtractor.extract(from: elements)
    }
}


struct Collage {
    var shapes: ShapeData
    private(set) var id: String = UUID().uuidString
}

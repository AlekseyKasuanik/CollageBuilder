//
//  ShapeData.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct ShapeData: Identifiable, Codable {
    var elements: [ShapeElement]
    
    private(set) var id: String = UUID().uuidString
    
    var controlPoints: [ControlPoint] {
        ControlPointsExtractor.extract(from: self)
    }
}


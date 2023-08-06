//
//  Collage.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 02.08.2023.
//

import Foundation

struct Collage: Codable {
    var shapes: [ShapeData]
    var dependencies: [DependentPoints]
    let id: String
    
    var controlPoints: [ControlPoint] {
        shapes.flatMap { $0.controlPoints }
    }
}

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
    var cornerRadius: CGFloat
    let id: String
    
    @CodableWrapper var background: CollageBackground
    
    var controlPoints: [ControlPoint] {
        shapes.flatMap { $0.controlPoints }
    }
}

extension Collage {
    static var empty: Collage {
        .init(shapes: [],
              dependencies: [],
              cornerRadius: 0,
              id: "1",
              background: .color(.white))
    }
}

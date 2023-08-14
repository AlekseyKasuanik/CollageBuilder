//
//  PointsRecognizer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.08.2023.
//

import Foundation

enum PointsRecognizer {
    
    static func findPoint(_ point: CGPoint,
                     in collage: Collage,
                     radius: CGFloat = 0.05) -> ControlPoint? {
        
        let allPoints = collage.shapes.flatMap { $0.controlPoints }
        
        let resultPoint = allPoints.first(where: {
            CGRect(
                size: .init(side: radius),
                araund: $0.point
            ).contains(point)
        })
        
        return resultPoint
    }
    
    static func findShape(_ point: CGPoint,
                          in collage: Collage) -> ShapeData? {
        
        let resultShapes = collage.shapes.first(where: { shape in
            PathCreator.create(
                size: .init(side: 1),
                shape: shape
            ).contains(point)
        })
        
        return resultShapes
    }
}

//
//  PointsRecognizer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.08.2023.
//

import Foundation

enum PointsRecognizer {
    
    static func find(_ point: CGPoint,
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
}

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
                around: $0.point
            ).contains(point)
        })
        
        return resultPoint
    }
    
    static func findShape(_ point: CGPoint,
                          in collage: Collage) -> ShapeData? {
        
        let shapes = collage.shapes.filter { shape in
            shape.fitRect.contains(point) &&
            PathCreator.create(
                size: .init(side: 1),
                shape: shape
            ).contains(
                CGPoint(x: point.x - shape.fitRect.minX,
                        y: point.y - shape.fitRect.minY)
            )
        }
        
        let filteredShapes = shapes.sorted(by: {
            $0.zPosition > $1.zPosition
        })
        
        return filteredShapes.first
    }
    
    static func findText(_ point: CGPoint,
                          in collage: Collage) -> TextSettings? {
        
        let texts = collage.texts.filter {
            $0.normalizedRect.contains(point)
        }
        
        let filteredTexts = texts.sorted(by: {
            $0.zPosition > $1.zPosition
        })
        
        return filteredTexts.first
    }
    
    static func findElement(_ point: CGPoint,
                            in collage: Collage) -> ElementType? {
        
        let shape = PointsRecognizer.findShape(point, in: collage)
        let text = PointsRecognizer.findText(point, in: collage)
        
        guard shape != nil || text != nil else {
            return nil
        }
        
        let element = [(ElementType.shape(shape?.id ?? ""), shape?.zPosition ?? .min),
                       (ElementType.text(text?.id ?? ""), text?.zPosition ?? .min)]
            .sorted(by: { $0.1 > $1.1})
            .first?.0
        
        return element
    }
    
    
}

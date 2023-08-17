//
//  PathCreator.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

enum PathCreator {
    
    static func create(size: CGSize, shape: ShapeData) -> Path {
        var path = Path()
        var isFirstPint = true
        var lastPoint: CGPoint?
        
        let offset = CGPoint(x: shape.fitRect.minX,
                             y: shape.fitRect.minY)
        
        for element in shape.elements {
            switch element {
            case .point(let point):
                if isFirstPint {
                    path.move(to: convertRelative(point - offset, in: size))
                    isFirstPint = false
                } else {
                    path.addLine(to: convertRelative(point - offset, in: size))
                }
                
                lastPoint = point
                
            case .curve(let endPoint, let control):
                guard let startPoint = lastPoint else {
                    break
                }
                
                let control = convertToControl(start: startPoint,
                                               through: control,
                                               end: endPoint)
                
                path.addQuadCurve(to: convertRelative(endPoint - offset, in: size),
                                  control: convertRelative(control - offset, in: size))
                
                lastPoint = endPoint
                
            case .rectangle(let rect):
                path.addRect(convertRelative(rect, in: size))
                
            case .ellipse(let rect):
                path.addEllipse(in: convertRelative(rect, in: size))
            }
            
        }
        
        return path
    }
    
    private static func convertToControl(start: CGPoint,
                                  through: CGPoint,
                                  end: CGPoint) -> CGPoint {
        
        let convector: (CGFloat, CGFloat, CGFloat) -> CGFloat = { start, through, end in
            let variablePoint = 0.5
            
            let control = through / (2 * variablePoint * (1 - variablePoint))
            - start * variablePoint / (2 * (1 - variablePoint))
            - end * (1 - variablePoint) / (2 * variablePoint)
            
            return control
        }
        
        let controlPoint = CGPoint(x: convector(start.x, through.x, end.x),
                                   y: convector(start.y, through.y, end.y))
        
        return controlPoint
    }
    
    
    private static func convertRelative(_ point: CGPoint, in size: CGSize) -> CGPoint {
        CGPoint(x: point.x * size.width,
                y: point.y * size.height)
    }
    
    private static func convertRelative(_ rect: CGRect, in size: CGSize) -> CGRect {
        CGRect(x: 0,
               y: 0,
               width: rect.width * size.width,
               height: rect.height * size.height)
    }
}

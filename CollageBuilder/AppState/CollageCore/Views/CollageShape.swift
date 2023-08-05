//
//  CollageShape.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct CollageShape: Shape {
    
    let shape: ShapeData
    let size: CGSize
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var isFirstPint = true
        var lastPoint: CGPoint?
        
        for element in shape.elements {
            switch element {
            case .point(let point):
                if isFirstPint {
                    path.move(to: convertRelative(point))
                    isFirstPint = false
                } else {
                    path.addLine(to: convertRelative(point))
                }
                
                lastPoint = point
                
            case .curve(let endPoint, let control):
                guard let startPoint = lastPoint else {
                    break
                }
                
                let control = convertToControl(start: startPoint,
                                               through: control,
                                               end: endPoint)
                
                path.addQuadCurve(to: convertRelative(endPoint),
                                  control: convertRelative(control))
                
                lastPoint = endPoint
                
            case .rectangle(let rect):
                path.addRect(convertRelative(rect))
                
            case .ellipse(let rect):
                path.addEllipse(in: convertRelative(rect))
            }
            
        }
        
        return path
    }
    
    private func convertToControl(start: CGPoint,
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
    
    
    private func convertRelative(_ point: CGPoint) -> CGPoint {
        CGPoint(x: point.x * size.width,
                y: point.y * size.height)
    }
    
    private func convertRelative(_ rect: CGRect) -> CGRect {
        CGRect(x: rect.minX * size.width,
               y: rect.minY * size.height,
               width: rect.width * size.width,
               height: rect.height * size.height)
    }
}

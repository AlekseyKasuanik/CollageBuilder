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
        
        for element in shape.elements {
            switch element {
            case .point(let point):
                if isFirstPint {
                    path.move(to: convertRelative(point))
                    isFirstPint = false
                } else {
                    path.addLine(to: convertRelative(point))
                }
                
            case .curve(let endPoint, let control):
                path.addQuadCurve(to: convertRelative(endPoint),
                                  control: convertRelative(control))
                
            case .rectangle(let rect):
                path.addRect(convertRelative(rect))
                
            case .ellipse(let rect):
                path.addEllipse(in: convertRelative(rect))
            }
            
        }
        
        return path
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

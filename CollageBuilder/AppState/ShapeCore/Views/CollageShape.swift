//
//  CollageShape.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct CollageShape: Shape {
    
    let shape: ShapeData
    
    func path(in rect: CGRect) -> Path {
        var path = Path()
        var isFirstPint = true
        
        for element in shape.elements {
            switch element {
            case .point(let point):
                if isFirstPint {
                    path.move(to: point)
                    isFirstPint = false
                } else {
                    path.addLine(to: point)
                }
                
            case .curve(let endPoint, let control):
                path.addQuadCurve(to: endPoint, control: control)
                
            case .rectangle(let rect):
                path.addRect(rect)
                
            case .ellipse(let rect):
                path.addEllipse(in: rect)
            }
            
        }
        
        return path
    }
}

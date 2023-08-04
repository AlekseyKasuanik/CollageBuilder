//
//  ControlPointsExtractor.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum ControlPointsExtractor {
    
    static func extract(from shape: ShapeData) -> [ControlPoint] {
        shape.elements.enumerated().flatMap {
            convert($0.element, wich: $0.offset, shapeID: shape.id)
        }
    }
    
    private static func convert(_ element: ShapeElement,
                                wich index: Int,
                                shapeID: String) -> [ControlPoint] {
        switch element {
        case .point(let point):
            return convert(point, wich: index, shapeID: shapeID)
            
        case .curve(let endPoint, let controlPoint):
            return convert(endPoint,
                           and: controlPoint,
                           wich: index,
                           shapeID: shapeID)
            
        case .rectangle(let rect), .ellipse(let rect):
            return convert(rect, wich: index, shapeID: shapeID)
        }
    }
    
    private static func convert(_ point: CGPoint,
                                wich index: Int,
                                shapeID: String) -> [ControlPoint] {
        
        [.init(point: point,
               indexInElement: index,
               type: .point,
               shapeID: shapeID)]
    }
    
    private static func convert(_ endPoint: CGPoint,
                                and controlPoint: CGPoint,
                                wich index: Int,
                                shapeID: String) -> [ControlPoint] {
        
        [.init(point: endPoint,
               indexInElement: index,
               type: .curveEnd,
               shapeID: shapeID),
         .init(point: controlPoint,
               indexInElement: index,
               type: .curveControl,
               shapeID: shapeID)]
    }
    
    private static func convert(_ rect: CGRect,
                                wich index: Int,
                                shapeID: String) -> [ControlPoint] {
        
        [.init(point: .init(x: rect.minX, y: rect.midY),
               indexInElement: index,
               type: .leftMidY,
               shapeID: shapeID),
         .init(point: .init(x: rect.maxX, y: rect.midY),
               indexInElement: index,
               type: .rightMidY,
               shapeID: shapeID),
         .init(point: .init(x: rect.midX, y: rect.maxY),
               indexInElement: index,
               type: .bottomMidX,
               shapeID: shapeID),
         .init(point: .init(x: rect.midX, y: rect.minY),
               indexInElement: index,
               type: .topMidX,
               shapeID: shapeID)]
    }
    
}

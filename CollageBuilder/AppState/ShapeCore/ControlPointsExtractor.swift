//
//  ControlPointsExtractor.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum ControlPointsExtractor {
    
    static func extract(from elements: [ShapeElement]) -> [ControlPoint] {
        elements.enumerated().flatMap {
            convert($0.element, wich: $0.offset)
        }
    }
    
    private static func convert(_ element: ShapeElement, wich index: Int) -> [ControlPoint] {
        switch element {
        case .point(let point):
            return convert(point, wich: index)
            
        case .curve(let endPoint, let controlPoint):
            return convert(endPoint, and: controlPoint, wich: index)
            
        case .rectangle(let rect), .ellipse(let rect):
            return convert(rect, wich: index)
        }
    }
    
    private static func convert(_ point: CGPoint, wich index: Int) -> [ControlPoint] {
        [.init(point: point, index: index, type: .point)]
    }
    
    private static func convert(_ endPoint: CGPoint,
                                and controlPoint: CGPoint,
                                wich index: Int) -> [ControlPoint] {
        
        [.init(point: endPoint, index: index, type: .curveEnd),
         .init(point: controlPoint, index: index, type: .curveControl)]
    }
    
    private static func convert(_ rect: CGRect, wich index: Int) -> [ControlPoint] {
        [.init(point: .init(x: rect.minX, y: rect.midY),
               index: index,
               type: .leftMidY),
         .init(point: .init(x: rect.maxX, y: rect.midY),
               index: index,
               type: .rightMidY),
         .init(point: .init(x: rect.midX, y: rect.maxY),
               index: index,
               type: .bottomMidX),
         .init(point: .init(x: rect.midX, y: rect.minY),
               index: index,
               type: .topMidX)]
    }
    
}

//
//  RectExtractor.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import Foundation

enum RectExtractor {
    
    static func extract(from shape: ShapeData) -> CGRect {
        let corners = shape.elements.reduce(Corners()) { corners, shape in
            cornersMather(old: corners, new: convert(shape))
        }
        
        let resultRect = CGRect(
            x: corners.minX,
            y: corners.minY,
            width: corners.maxX - corners.minX,
            height: corners.maxY - corners.minY
        )
        
        return resultRect
    }
    
    private static func cornersMather(old: Corners, new: Corners) -> Corners {
        var result = old
        
        if new.minX < old.minX { result.minX = new.minX }
        if new.minY < old.minY { result.minY = new.minY }
        if new.maxX > old.maxX { result.maxX = new.maxX }
        if new.maxY > old.maxY { result.maxY = new.maxY }
        
        return result
    }
    
    private static func convert(_ element: ShapeElement) -> Corners {
        switch element {
        case .point(let point):
            return .init(
                minX: point.x,
                minY: point.y,
                maxX: point.x,
                maxY: point.y
            )
            
        case .curve(let endPoint, let control):
            return .init(
                minX: min(endPoint.x, control.x),
                minY: min(endPoint.y, control.y),
                maxX: max(endPoint.x, control.x),
                maxY: max(endPoint.y, control.y)
            )
            
        case .rectangle(let rect), .ellipse(let rect):
            return .init(rect: rect)
        }
    }
    
}

fileprivate struct Corners {
    var minX: CGFloat = 1
    var minY: CGFloat = 1
    var maxX: CGFloat = 0
    var maxY: CGFloat = 0
}

fileprivate extension Corners {
    init(rect: CGRect) {
        self.minX = rect.minX
        self.minY = rect.minY
        self.maxX = rect.maxX
        self.maxY = rect.maxY
    }
}

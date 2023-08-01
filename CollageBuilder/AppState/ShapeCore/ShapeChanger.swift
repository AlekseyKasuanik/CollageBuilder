//
//  ShapeChanger.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 01.08.2023.
//

import Foundation

struct ShapeChanger {
    let pointTouchSide: CGFloat
    
    private var movedPoint: ControlPoint?
    
    init(pointTouchSide: CGFloat = 0.02) {
        self.pointTouchSide = pointTouchSide
    }
    
    mutating func translate(_ translation: GestureState,
                            in shape: ShapeData) -> ShapeData {
        
        switch translation {
        case .began(let position):
            changeMovedPoint(position, in: shape)
            return shape
            
        case .changed(let translation):
            return translatePoint(translation, in: shape)
        }
    }
    
    private mutating func changeMovedPoint(_ point: CGPoint,
                                           in shape: ShapeData) {
        
        let allPoints = shape.controlPoints
        
        movedPoint = allPoints.first(where: {
            CGRect(
                size: .init(side: pointTouchSide),
                araund: $0.point
            ).contains(point)
        })
        
    }
    
    private mutating func translatePoint(_ translation: CGPoint,
                                         in shape: ShapeData) -> ShapeData {
        
        guard let point = movedPoint?.point else {
            return shape
        }
        
        movedPoint?.point = .init(x: point.x + translation.x,
                                  y: point.y + translation.y)
        
        guard let movedPoint else {
            return shape
        }
        
        var newShape = shape
        newShape.elements = ElementsChanger.change(
            movedPoint,
            in: shape.elements
        )
        
        return newShape
    }
    
}

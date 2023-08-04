//
//  CollageChanger.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 01.08.2023.
//

import Foundation

struct CollageChanger {
    let pointTouchSide: CGFloat
    
    private var movedPoint: ControlPoint?
    
    init(pointTouchSide: CGFloat = 0.05) {
        self.pointTouchSide = pointTouchSide
    }
    
    mutating func translate(_ translation: GestureState,
                            in collage: Collage) -> Collage {
        
        switch translation {
        case .began(let position):
            changeMovedPoint(position, in: collage)
            return collage
            
        case .changed(let translation):
            return translatePoint(translation, in: collage)
        }
    }
    
    private mutating func changeMovedPoint(_ point: CGPoint,
                                           in collage: Collage) {
        
        movedPoint = PointsRecognizer.find(
            point,
            in: collage,
            radius: pointTouchSide
        )
    }
    
    private mutating func translatePoint(_ translation: CGPoint,
                                         in collage: Collage) -> Collage {
        
        movedPoint?.point.x += translation.x
        movedPoint?.point.y += translation.y
        
        guard let point = movedPoint else {
            return collage
        }
        
        var dependedPoints = getDependedPoints(in: collage)
        
        dependedPoints.enumerated().forEach { index, point in
            dependedPoints[index].point = .init(
                x: point.point.x + translation.x,
                y: point.point.y + translation.y
            )
        }
        
        let allPoints = Array(Set([point] + dependedPoints))
        
        return setPoints(allPoints, to: collage)
    }
    
    private func getDependedPoints(in collage: Collage) -> [ControlPoint] {
        guard let movedPoint,
              let group = collage.dependencies.first(where: {
                  $0.pointIDs.contains(movedPoint.id)
              }) else {
            return []
        }
        
        let points = collage.controlPoints.filter{
            group.pointIDs.contains($0.id)
        }
        
        return points
    }
    
    private func setPoints(_ points: [ControlPoint],
                           to collage: Collage) -> Collage {
        
        var newCollage = collage
        
        points.forEach { point in
            guard let shapeIndex = collage.shapes.firstIndex(where: {
                      $0.id == point.shapeID
                  }) else {
                return
            }
            
            var newShape = collage.shapes[shapeIndex]
            newShape.elements = ElementsChanger.change(
                point,
                in: newShape.elements
            )
            
            newCollage.shapes[shapeIndex] = newShape
        }
        
        return newCollage
    }
    
    
    
}

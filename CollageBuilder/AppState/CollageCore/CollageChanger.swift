//
//  CollageChanger.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 01.08.2023.
//

import Foundation

struct CollageChanger {
    let pointTouchSide: CGFloat
    let transalationStep: CGFloat
    
    private var movedPoint: ControlPoint?
    private var accumulatedTranslation: CGPoint = .zero
    
    init(pointTouchSide: CGFloat = 0.05,
         transalationStep: CGFloat = 0) {
        
        self.pointTouchSide = pointTouchSide
        self.transalationStep = transalationStep
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
        
        let coorectTransation = getCoorectTranslation(translation)
        
        movedPoint?.point.x += coorectTransation.x
        movedPoint?.point.y += coorectTransation.y
        
        guard let point = movedPoint else {
            return collage
        }
        
        var dependedPoints = getDependedPoints(in: collage)
        
        dependedPoints.enumerated().forEach { index, point in
            dependedPoints[index].point = .init(
                x: point.point.x + coorectTransation.x,
                y: point.point.y + coorectTransation.y
            )
        }
        
        let allPoints = Array(Set([point] + dependedPoints))
        
        return setPoints(allPoints, to: collage)
    }
    
    private mutating func getCoorectTranslation(_ translation: CGPoint) -> CGPoint {
        let sumTranslation = accumulatedTranslation + translation
        
        let remainderX = sumTranslation.x.truncatingRemainder(dividingBy: transalationStep)
        let remainderY = sumTranslation.y.truncatingRemainder(dividingBy: transalationStep)
        
        let resultTranslation = CGPoint(
            x: sumTranslation.x - remainderX,
            y: sumTranslation.y - remainderY
        )
        
        accumulatedTranslation = .init(x: remainderX,
                                       y: remainderY)
        
        return resultTranslation
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

//
//  ShapesTranslator.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 01.08.2023.
//

import Foundation

struct ShapesTranslator: ShapesTranslatorProtocol {
    let pointTouchSide: CGFloat
    let translationStep: CGFloat
    
    private var movedPointsIDs = [String]()
    private var accumulatedTranslation = CGPoint.zero
    
    init(pointTouchSide: CGFloat = 0.05,
         translationStep: CGFloat = 0) {
        
        self.pointTouchSide = pointTouchSide
        self.translationStep = translationStep
    }
    
    mutating func translate(_ translation: GestureType.GestureState<CGPoint>,
                            in collage: Collage) -> Collage {
        
        switch translation {
        case .began(let position):
            changeMovedPoints(position, in: collage)
            return collage
            
        case .changed(let translation):
            return translatePoint(translation, in: collage)
        }
    }
    
    private mutating func changeMovedPoints(_ point: CGPoint,
                                            in collage: Collage) {
        
        if let point = PointsRecognizer.findPoint(
            point,
            in: collage,
            radius: pointTouchSide
        ) {
            movedPointsIDs = [point.id]
            
        } else if let shape = PointsRecognizer.findShape(
            point,
            in: collage
        ) {
            movedPointsIDs = shape.controlPoints.map(\.id)
        }
    }
    
    private mutating func translatePoint(_ translation: CGPoint,
                                         in collage: Collage) -> Collage {
        
        let coorectTransation = getCoorectTranslation(translation)
        
        let allPoints = getAllPointsForTranslation(in: collage)
        
        let translatedPoints = allPoints.map { controlPoint in
            var newPoint = controlPoint
            newPoint.point = .init(
                x: newPoint.point.x + coorectTransation.x,
                y: newPoint.point.y + coorectTransation.y
            )
            
            return newPoint
        }
    
        return setPoints(translatedPoints, to: collage)
    }
    
    private mutating func getCoorectTranslation(_ translation: CGPoint) -> CGPoint {
        let sumTranslation = accumulatedTranslation + translation
        
        let remainderX = sumTranslation.x.truncatingRemainder(dividingBy: translationStep)
        let remainderY = sumTranslation.y.truncatingRemainder(dividingBy: translationStep)
        
        let resultTranslation = CGPoint(
            x: sumTranslation.x - remainderX,
            y: sumTranslation.y - remainderY
        )
        
        accumulatedTranslation = .init(x: remainderX,
                                       y: remainderY)
        
        return resultTranslation
    }
    
    private func getAllPointsForTranslation(in collage: Collage) -> [ControlPoint] {
        
        let allPoints = movedPointsIDs.reduce([ControlPoint]()) { allPoints, pointID in
            if let group = collage.dependencies.first(where: {
                $0.pointIDs.contains(pointID)
            }) {
                let points = collage.controlPoints.filter {
                    group.pointIDs.contains($0.id)
                }
                return allPoints + points
            }
            
            let point = collage.controlPoints.filter { $0.id == pointID }
            
            return allPoints + point
        }
        
        return allPoints
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
            
            var newShape = newCollage.shapes[shapeIndex]
            newShape.elements = ElementsChanger.change(
                point,
                in: newShape.elements
            )
            
            newCollage.shapes[shapeIndex] = newShape
        }
        
        return newCollage
    }
    
}

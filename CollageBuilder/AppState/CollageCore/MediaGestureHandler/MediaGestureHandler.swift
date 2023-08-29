//
//  MediaGestureHandler.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 27.08.2023.
//

import Foundation

struct MediaGestureHandler {
    
    private var shangedShapeID: String?
    
    mutating func translate(_ gestureState: GestureType.GestureState<CGPoint>,
                            in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedShape(position, in: collage)
            return collage
            
        case .changed(let translation):
            return translate(translation, in: collage)
        }
        
    }
    
    mutating func scale(_ gestureState: GestureType.GestureState<CGFloat>,
                        in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedShape(position, in: collage)
            return collage
            
        case .changed(let value):
            return scale(value, in: collage)
        }
    }
    
    mutating func rotate(_ gestureState: GestureType.GestureState<CGFloat>,
                         in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedShape(position, in: collage)
            return collage
            
        case .changed(let rotation):
            return rotate(rotation, in: collage)
        }
    }
    
    private func translate(_ translation: CGPoint,
                           in collage: Collage) -> Collage {
        
        guard let shapeIndex = collage.shapes.firstIndex(where: {
            $0.id == shangedShapeID
        }) else {
            return collage
        }
        
        var newCollage = collage
        var newShape = collage.shapes[shapeIndex]
        
        newShape.mediaTransforms.translation = newShape.mediaTransforms.translation + translation
        newCollage.shapes[shapeIndex] = newShape
        
        return newCollage
    }
    
    private func scale(_ scale: CGFloat,
                       in collage: Collage) -> Collage {
        
        guard let shapeIndex = collage.shapes.firstIndex(where: {
            $0.id == shangedShapeID
        }) else {
            return collage
        }
        
        var newCollage = collage
        var newShape = collage.shapes[shapeIndex]
        
        newShape.mediaTransforms.scale *= scale
        newCollage.shapes[shapeIndex] = newShape
        
        return newCollage
    }
    
    private func rotate(_ rotation: CGFloat,
                       in collage: Collage) -> Collage {
        
        guard let shapeIndex = collage.shapes.firstIndex(where: {
            $0.id == shangedShapeID
        }) else {
            return collage
        }
        
        var newCollage = collage
        var newShape = collage.shapes[shapeIndex]
        
        newShape.mediaTransforms.rotaion += rotation
        newCollage.shapes[shapeIndex] = newShape
        
        return newCollage
    }
    
    private mutating func detectChangedShape(_ position: CGPoint,
                                             in collage: Collage) {
        
        shangedShapeID = PointsRecognizer.findShape(
            position,
            in: collage
        )?.id
    }
    
}

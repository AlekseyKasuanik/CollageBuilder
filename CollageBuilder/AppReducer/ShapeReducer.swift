//
//  ShapeReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import Foundation

struct ShapeReducer: ReducerProtocol {
    
    
    mutating func reduce(_ currentState: ShapeData,
                         _ action: ShapeModification) -> ShapeData {
        
        var newShape = currentState
        
        switch action {
        case .addElement(let element):
            newShape.elements.append(element)
            
        case .changeMedia(let media):
            newShape.media = media
            
        case .changeBlendMode(let blendMode):
            newShape.blendMode = blendMode
            
        case .changeZPosition(let position):
            newShape.zPosition = position
            
        case .changeBlur(let blur):
            newShape.blur = blur
            
        case .changeAdjustments(let adjustments):
            newShape.adjustments = adjustments
            
        case .changeFilter(let filter):
            newShape.filter = filter
        }
        
        return newShape
        
    }
    
}

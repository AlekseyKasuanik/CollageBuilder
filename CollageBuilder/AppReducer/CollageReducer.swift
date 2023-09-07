//
//  CollageReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

struct CollageReducer: ReducerProtocol {
    
    private var shapeReducer = ShapeReducer()
    private var textReducer = TextReducer()
    
    mutating func reduce(_ currentState: Collage,
                         _ action: CollageModification) -> Collage {
        
        var newCollage = currentState
        
        switch action {
        case .addShape(let shapeData):
            newCollage = addShape(shapeData, to: newCollage)
            
        case .changeBackground(let collageBackground):
            newCollage = changeBackground(collageBackground, in: newCollage)
            
        case .connectControlPoints(let ids):
            newCollage = connectControlPoints(ids, in: newCollage)
            
        case .disconnectControlPoints(let ids):
            newCollage = disconnectControlPoints(ids, in: newCollage)
            
        case .changeCornerRadius(let radius):
            newCollage = changeCornerRadius(radius, in: newCollage)
            
        case .changeShape(let action, id: let id):
            newCollage = changeShape(action, id: id, in: newCollage)
            
        case .addText(let text):
            newCollage = addText(text, to: newCollage)
            
        case .changeText(let action, id: let id):
            newCollage = changeText(action, id: id, in: newCollage)
        }
        
        return newCollage
        
    }
    
    private mutating func changeShape(_ action: ShapeModification,
                             id: String,
                             in collage: Collage) -> Collage {
        
        guard let shapeIndex = collage.shapes.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.shapes[shapeIndex] = shapeReducer.reduce(
            newCollage.shapes[shapeIndex],
            action
        )
        
        return newCollage
    }
    
    private mutating func changeText(_ action: TextModification,
                                     id: String,
                                     in collage: Collage) -> Collage {
        
        guard let textIndex = collage.texts.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.texts[textIndex] = textReducer.reduce(
            newCollage.texts[textIndex],
            action
        )
        
        return newCollage
    }
    
    private mutating func changeBackground(_ action: ShapeModification,
                                           in collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.background = shapeReducer.reduce( newCollage.background, action)
        return newCollage
    }
    
    private func addShape(_ shape: ShapeData,
                          to collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.shapes.append(shape)
        return newCollage
    }
    
    private func connectControlPoints(_ ids: Set<String>,
                                     in collage: Collage) -> Collage {
        
        var newCollage = collage
        guard let index = newCollage.dependencies.firstIndex(where: {
            !$0.pointIDs.intersection(ids).isEmpty
        }) else {
            newCollage.dependencies.append(.init(pointIDs: ids))
            return newCollage
        }
        
        newCollage.dependencies[index] = .init(pointIDs: ids)
        
        return newCollage
    }
    
    private func disconnectControlPoints(_ ids: Set<String>,
                                        in collage: Collage) -> Collage {
        
        guard let index = collage.dependencies.firstIndex(where: {
            $0.pointIDs.isSubset(of: ids)
        }) else {
            return collage
        }
        
        var newCollage = collage
        newCollage.dependencies.remove(at: index)
        
        return newCollage
    }
    
    private func changeCornerRadius(_ radius: CGFloat,
                                    in collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.cornerRadius = radius
        return newCollage
    }
    
    private func addText(_ text: TextSettings,
                          to collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.texts.append(text)
        return newCollage
    }
}

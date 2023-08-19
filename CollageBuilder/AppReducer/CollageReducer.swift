//
//  CollageReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

struct CollageReducer: ReducerProtocol {
    
    private var shapeReducer = ShapeReducer()
    
    mutating func reduce(_ currentState: Collage,
                         _ action: CollageModification) -> Collage {
        
        var newCollage = currentState
        
        switch action {
        case .addShape(let shapeData):
            newCollage = addShape(shapeData, to: newCollage)
            
        case .changeBackground(let collageBackground):
            newCollage = changeBackground(collageBackground, in: newCollage)
            
        case .conectControlPoints(let ids):
            newCollage = conectControlPoints(ids, in: newCollage)
            
        case .disconectControlPoints(let ids):
            newCollage = disconectControlPoints(ids, in: newCollage)
            
        case .cnahgeCornerRadius(let radius):
            newCollage = changeCornerRadius(radius, in: newCollage)
            
        case .changeShape(let action, id: let id):
            newCollage = changeShape(action, id: id, in: newCollage)
        }
        
        return newCollage
        
    }
    
    private mutating func changeShape(_ action: ShapeModification,
                             id: String,
                             in collage: Collage) -> Collage {
        
        guard let shpaeIndex = collage.shapes.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.shapes[shpaeIndex] = shapeReducer.reduce(
            newCollage.shapes[shpaeIndex],
            action
        )
        
        return newCollage
    }
    
    private func changeBackground(_ background: CollageBackground,
                                  in collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.background = background
        return newCollage
    }
    
    private func addShape(_ shape: ShapeData,
                          to collage: Collage) -> Collage {
        
        var newCollage = collage
        newCollage.shapes.append(shape)
        return newCollage
    }
    
    private func conectControlPoints(_ ids: Set<String>,
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
    
    private func disconectControlPoints(_ ids: Set<String>,
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
}

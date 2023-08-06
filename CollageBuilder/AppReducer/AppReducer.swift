//
//  AppReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppReducer: ReducerProtocol {
    
    var collageChanger = CollageChanger(pointTouchSide: 0.1,
                                        transalationStep: 0.01)
    
    mutating func reduce(_ currentState: AppState, _ action: AppAction) -> AppState {
        var newState = currentState
        
        switch action {
        case .translateConrolPoint(let gestureState):
            newState.collage = collageChanger.translate(
                gestureState,
                in: newState.collage
            )
        case .conectControlPoints(let ids):
            guard let index = newState.collage.dependencies.firstIndex(where: {
                !$0.pointIDs.intersection(ids).isEmpty
            }) else {
                newState.collage.dependencies.append(.init(pointIDs: ids))
                break
            }
            
            newState.collage.dependencies[index] = .init(pointIDs: ids)
            
        case .addShape(let shape):
            newState.collage.shapes.append(shape)
            
        case .addElement(let element, shapeId: let id):
            guard let index = newState.collage.shapes.firstIndex(where: {
                $0.id == id
            }) else {
                break
            }
            newState.collage.shapes[index].elements.append(element)
            
        case .setCollage(let collage):
            newState.collage = collage
        }
        
        return newState
    }
    
}


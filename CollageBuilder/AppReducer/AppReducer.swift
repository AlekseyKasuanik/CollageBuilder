//
//  AppReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppReducer: ReducerProtocol {
    
    var collageChanger = CollageChanger()
    
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
        }
        
        return newState
    }
    
}


//
//  AppReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppReducer: ReducerProtocol {
    
    var shapeChanger = ShapeChanger()
    
    mutating func reduce(_ currentState: AppState, _ action: AppAction) -> AppState {
        var newState = currentState
        
        switch action {
        case .translateConrolPoint(let gestureState):
            newState.shape = shapeChanger.translate(gestureState, in: currentState.shape)
        }
        
        return newState
    }
    
}

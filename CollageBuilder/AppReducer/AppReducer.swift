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
    
    var collageReducer = CollageReducer()
    
    mutating func reduce(_ currentState: AppState,
                         _ action: AppAction) -> AppState {
        
        var newState = currentState
        
        switch action {
        case .translate(let gestureState):
            newState.collage = collageChanger.translate(
                gestureState,
                in: newState.collage
            )
            
        case .changeCollage(let modification):
            newState.collage = collageReducer.reduce(newState.collage, modification)
            
        case .setCollage(let collage):
            newState.collage = collage
            
        case .selectShape(let id):
            newState.selectedShapeID = id
        }
        
        return newState
    }
    
    private func getShapeIndex(id: String, in state: AppState) -> Int? {
        state.collage.shapes.firstIndex(where: {
            $0.id == id
        })
    }
}


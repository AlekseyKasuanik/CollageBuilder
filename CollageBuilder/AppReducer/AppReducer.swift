//
//  AppReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppReducer: ReducerProtocol {
    
    
    var collageReducer = CollageReducer()
    var gestureReducer = GestureReducer()
    
    mutating func reduce(_ currentState: AppState,
                         _ action: AppAction) -> AppState {
        
        var newState = currentState
        
        switch action {
        case .changeCollage(let modification):
            newState.collage = collageReducer.reduce(newState.collage, modification)
            
        case .setCollage(let collage):
            newState.collage = collage
            
        case .selectShape(let id):
            newState.selectedShapeID = id
            
        case .gesture(let action):
            newState = gestureReducer.reduce(newState, action)
            
        case .removeSelectedPoints:
            newState.selectedPointsIDs.removeAll()
            
        case .swithEditMode:
            newState.editMode.next()
            
        case .toggleGrid:
            newState.isShowingGrid.toggle()
            
        case .togglePlayColalge:
            newState.isPlayingCollage.toggle()
        }
        
        return newState
    }
    
}


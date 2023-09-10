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
            newState = changeCollage(modification, state: newState)
            
        case .setCollage(let collage):
            newState.collage = collage
            
        case .selectElement(let element):
            newState.selectedElement = element
            
        case .gesture(let action):
            newState = gestureReducer.reduce(newState, action)
            
        case .removeSelectedPoints:
            newState.selectedPointsIDs.removeAll()
            
        case .switchEditMode:
            newState.editMode.next()
            
        case .toggleGrid:
            newState.isShowingGrid.toggle()
            
        case .togglePlayCollage:
            newState.isPlayingCollage.toggle()
        }
        
        return newState
    }
    
    private mutating func changeCollage(_ action: CollageModification,
                                        state: AppState) -> AppState {
        
        var newState = state
        newState.collage = collageReducer.reduce(newState.collage, action)
        
        switch action {
        case .removeShape, .removeText, .removeSticker:
            newState.selectedElement = nil
            
        default:
            break
        }
        
        return newState
    }
    
}


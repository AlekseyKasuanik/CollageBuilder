//
//  GestureReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import Foundation

struct GestureReducer: ReducerProtocol {
    
    private var mediaGestureHandler = MediaGestureHandler()
    private var shapesTranslator = ShapesTranslator(pointTouchSide: 0.1,
                                                    transalationStep: 0.01)
    
    mutating func reduce(_ currentState: AppState,
                         _ action: GestureType) -> AppState {
        
        var newState = currentState
        
        switch action {
        case .tap(let point):
            newState = onTap(point, in: newState)
            
        case .longTap(let point):
            newState = onLongTap(point, in: newState)
            
        case .scale(let gestureState):
            newState = onSale(gestureState, in: newState)
            
        case .translate(let gestureState):
            newState = onTranslate(gestureState, in: newState)
            
        case .twoFingersTranslate(let gestureState):
            newState = onTwoFingersTranslate(gestureState, in: newState)
            
        case .rotate(let gestureState):
            newState = onRotate(gestureState, in: newState)
        }
        
        return newState
        
    }
    
    private mutating func onTranslate(_ gestureState: GestureType.GestureState<CGPoint>,
                                      in state: AppState) -> AppState {
        
        var newState = state
        switch state.editMode {
        case .priview:
            newState.collage = mediaGestureHandler.translate(
                gestureState,
                in: state.collage
            )
            
        case .edit:
            newState.collage = shapesTranslator.translate(
                gestureState,
                in: newState.collage
            )
        }
        
        return newState
    }
    
    private mutating func onSale(_ gestureState: GestureType.GestureState<CGFloat>,
                                 in state: AppState) -> AppState {
        
        var newState = state
        switch state.editMode {
        case .priview:
            newState.collage = mediaGestureHandler.scale(
                gestureState,
                in: state.collage
            )
            
        case .edit:
            if case .changed(let scale) = gestureState {
                newState.collageSettings.scale *= scale
            }
        }
        
        return newState
    }
    
    private mutating func onRotate(_ gestureState: GestureType.GestureState<CGFloat>,
                                   in state: AppState) -> AppState {
        
        guard state.editMode == .priview else {
            return state
        }
        
        var newState = state
        newState.collage = mediaGestureHandler.rotate(
            gestureState,
            in: state.collage
        )
        
        return newState
    }
    
    private func onTap(_ point: CGPoint,
                       in state: AppState) -> AppState {
        
        let shape = PointsRecognizer.findShape(
            point,
            in: state.collage
        )
        
        var newState = state
        newState.selectedShapeID = shape?.id
        
        return newState
    }
    
    private func onLongTap(_ point: CGPoint,
                           in state: AppState) -> AppState {
        
        guard let pointID = PointsRecognizer.findPoint(
            point,
            in: state.collage
        )?.id else {
            return state
        }
        
        var newState = state
        
        if newState.selectedPointsIDs.isEmpty,
           let dependencies = state.collage.dependencies.first(where: {
               $0.pointIDs.contains(pointID)
           }) {
            newState.selectedPointsIDs.formUnion(dependencies.pointIDs)
        }
        
        newState.selectedPointsIDs.update(with: pointID)
        
        return newState
    }
    
    private func onTwoFingersTranslate(_ gestureState: GestureType.GestureState<CGPoint>,
                                       in state: AppState) -> AppState {
        
        var newState = state
        
        if case .changed(let translation) = gestureState {
            let newTranslation = newState.collageSettings.translation + translation
            newState.collageSettings.translation = newTranslation
        }
        
        return newState
    }
    
}

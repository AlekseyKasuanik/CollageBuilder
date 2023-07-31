//
//  AppReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppReducer: ReducerProtocol {
    
    func reduce(_ currentState: AppState, _ action: AppAction) -> AppState {
        switch action {
        case .translateConrolPoint(let state):
            break
        }
        
        return currentState
    }
    
}

//
//  MaskSettingsReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 26.09.2023.
//

import Foundation

protocol MaskSettingsReducerProtocol {
    mutating func reduce(_ currentState: MaskSettings?,
                         _ action: MaskSettingsModification) -> MaskSettings?
}

struct MaskSettingsReducer: MaskSettingsReducerProtocol {
    
    mutating func reduce(_ currentState: MaskSettings?,
                         _ action: MaskSettingsModification) -> MaskSettings? {
        
        var newState = currentState

        
        return newState
        
    }
    
}

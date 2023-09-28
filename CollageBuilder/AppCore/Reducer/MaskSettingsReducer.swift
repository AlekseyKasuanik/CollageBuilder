//
//  MaskSettingsReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 26.09.2023.
//

import SwiftUI

protocol MaskSettingsReducerProtocol {
    mutating func reduce(_ currentState: MaskSettings?,
                         _ action: MaskSettingsModification) -> MaskSettings?
}

struct MaskSettingsReducer: MaskSettingsReducerProtocol {
    
    mutating func reduce(_ currentState: MaskSettings?,
                         _ action: MaskSettingsModification) -> MaskSettings? {
        
        var newState = currentState
        
        switch action {
        case .change(let mask):
            newState = changeMask(mask, in: newState)
        case .createMask:
            break
        }
        
        return newState
    }
    
    private func changeMask(_ mask: UIImage?,
                            in state: MaskSettings?) -> MaskSettings? {
        
        guard let mask else { return nil }
        
        guard var state else {
            return .init(mask: mask)
        }
        
        state.mask = mask
        return state
    }
    
}

//
//  StickerReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import Foundation

struct StickerReducer: ReducerProtocol {
    
    
    mutating func reduce(_ currentState: Sticker,
                         _ action: StickerModification) -> Sticker {
        
        var newState = currentState
        
        switch action {
        case .mask(let mask):
            newState.mask = mask
        }
        
        return newState
    }
    
}

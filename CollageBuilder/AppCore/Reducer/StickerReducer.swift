//
//  StickerReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import Foundation

protocol StickerReducerProtocol {
    mutating func reduce(_ currentState: Sticker,
                         _ action: StickerModification) -> Sticker
}

struct StickerReducer: StickerReducerProtocol {
    
    mutating func reduce(_ currentState: Sticker,
                         _ action: StickerModification) -> Sticker {
        
        var newState = currentState
        
        switch action {
        case .changeMask(let mask):
            newState.mask = mask
            
        case .changeBlendMode(let mode):
            newState.blendMode = mode
            
        case .changeZPosition(let index):
            newState.zPosition = index
            
        case .changeAnimation(let animation):
            newState.animation = animation
        }

        return newState
    }
    
}

//
//  MediaReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 16.09.2023.
//

import Foundation

protocol MediaReducerProtocol {
    mutating func reduce(_ currentState: Media?,
                         _ action: MediaModification) -> Media?
}

struct MediaReducer: MediaReducerProtocol {
    
    private(set) var videoSettingsReducer: VideoSettingsReducerProtocol
    private(set) var maskSettingsReducer: MaskSettingsReducerProtocol
    
    mutating func reduce(_ currentState: Media?,
                         _ action: MediaModification) -> Media? {
        
        var newState = currentState
        
        switch action {
        case .replace(let media):
            
            newState = media
        case .changeVideoSettings(let action):
            newState = changeSettings(in: newState, action: action)
        case .createMask(let action):
            let maskSettings = maskSettingsReducer.reduce(newState?.maskSettings, action)
            newState?.maskSettings = maskSettings
        }
        
        return newState
        
    }
    
    private mutating func changeSettings(in media: Media?,
                                         action: VideoSettingsModification) -> Media? {
        
        guard var settings = media?.videoSettings else {
            return media
        }
        
        settings = videoSettingsReducer.reduce(settings, action)
        
        var newMedia = media
        newMedia?.videoSettings = settings
        
        return newMedia
    }
    
}

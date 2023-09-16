//
//  VideoSettingsReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.09.2023.
//

import Foundation

protocol VideoSettingsReducerProtocol {
    mutating func reduce(_ currentState: VideoSettings,
                         _ action: VideoSettingsModification) -> VideoSettings
}

struct VideoSettingsReducer: VideoSettingsReducerProtocol {
    
    mutating func reduce(_ currentState: VideoSettings,
                         _ action: VideoSettingsModification) -> VideoSettings {
        
        var newSettings = currentState
        
        switch action {
        case .changeTrim(let videoTrim):
            newSettings.trim = videoTrim
            
        case .changeSpeed(let speed):
            newSettings.speed = Float(speed)
            
        case .changeIsMute(let isMuted):
            newSettings.isMuted = isMuted
        }
        
        return newSettings
        
    }
    
}

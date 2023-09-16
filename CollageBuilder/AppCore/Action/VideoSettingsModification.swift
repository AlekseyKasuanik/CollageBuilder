//
//  VideoSettingsModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.09.2023.
//

import Foundation

enum VideoSettingsModification {
    case changeTrim(VideoTrim?)
    case changeSpeed(CGFloat)
    case changeIsMute(Bool)
}

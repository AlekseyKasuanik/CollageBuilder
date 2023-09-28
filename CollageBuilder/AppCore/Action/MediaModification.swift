//
//  MediaModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.09.2023.
//

import Foundation

enum MediaModification {
    case replace(Media?)
    case changeVideoSettings(VideoSettingsModification)
    case changeMask(MaskSettingsModification)
}

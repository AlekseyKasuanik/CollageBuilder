//
//  StickerModification.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import SwiftUI

enum StickerModification {
    case changeMask(UIImage)
    case changeBlendMode(ContentBlendMode)
    case changeZPosition(Int)
}

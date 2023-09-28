//
//  MaskSettings.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 26.09.2023.
//

import SwiftUI

struct MaskSettings: Codable {
    @CodableWrapper var mask: UIImage
}

extension MaskSettings: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.mask == rhs.mask
    }
}

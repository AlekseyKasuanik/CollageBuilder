//
//  NSTextAlignment+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import SwiftUI

extension NSTextAlignment {
    
    init(textAlignment: TextSettings.TextAlignment) {
        switch textAlignment {
        case .left:
            self = .left
        case .right:
            self = .right
        case .center:
            self = .center
        }
    }
}

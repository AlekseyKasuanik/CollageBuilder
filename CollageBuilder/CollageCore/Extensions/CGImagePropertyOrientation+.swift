//
//  CGImagePropertyOrientation+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 27.08.2023.
//

import SwiftUI

extension CGImagePropertyOrientation {
    init(_ uiOrientation: UIImage.Orientation) {
        switch uiOrientation {
        case .up:
            self = .up
            
        case .upMirrored:
            self = .upMirrored
            
        case .down:
            self = .down
            
        case .downMirrored:
            self = .downMirrored
            
        case .left:
            self = .left
            
        case .leftMirrored:
            self = .leftMirrored
            
        case .right:
            self = .right
            
        case .rightMirrored:
            self = .rightMirrored
            
        @unknown default:
            self = .up
        }
    }
}

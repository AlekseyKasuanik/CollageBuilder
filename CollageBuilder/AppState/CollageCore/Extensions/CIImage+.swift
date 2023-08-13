//
//  CIImage+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 13.08.2023.
//

import CoreImage

extension CIImage {
    
    func scaled(by scale: CGFloat) -> CIImage {
        return self.transformed(by: CGAffineTransform(scaleX: scale, y: scale))
    }
    
}


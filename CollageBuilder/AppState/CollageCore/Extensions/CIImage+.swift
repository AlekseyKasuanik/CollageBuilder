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
    
    func withModifiers(_ modifiers: [Modifier]) -> CIImage {
        modifiers.reduce(self) { resultImage, modifier in
            modifier.modify(resultImage)
        }
    }
    
    func cropped(to size: CGSize) -> CIImage {
        self.cropped(to: .init(
            x: (extent.width - size.width) / 2,
            y: (extent.height - size.height) / 2,
            width: size.width,
            height: size.height
        ))
    }
    
}


//
//  CIImage+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 13.08.2023.
//

import CoreImage

extension CIImage {
    
    func translated(by x: CGFloat, y: CGFloat) -> CIImage {
        return self.transformed(by: CGAffineTransform(translationX: x, y: y))
    }
    
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
    
    func croppedAndScaled(to size: CGSize) -> CIImage {
        let scale = min(extent.width / size.width,
                        extent.height / size.height)
        
        let scaledImage = self.scaled(by: 1 / scale)
        
        let croppedImage = scaledImage.cropped(to: .init(
            x: (scaledImage.extent.width - size.width) / 2,
            y: (scaledImage.extent.height - size.height) / 2,
            width: size.width,
            height: size.height
        ))
        
        return croppedImage.translattedToZero()
    }
    
    func translattedToZero() -> CIImage {
        self.translated(by: -extent.minX, y: -extent.minY)
    }
}


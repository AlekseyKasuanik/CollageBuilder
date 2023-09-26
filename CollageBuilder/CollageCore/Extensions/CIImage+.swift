//
//  CIImage+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 13.08.2023.
//

import CoreImage

extension CIImage {
    
    func translated(by x: CGFloat, y: CGFloat) -> CIImage {
        transformed(by: CGAffineTransform(translationX: x, y: y))
    }
    
    func translated(by point: CGPoint) -> CIImage {
        translated(by: point.x, y: point.y)
    }
    
    func scaled(by scale: CGFloat) -> CIImage {
        transformed(by: CGAffineTransform(scaleX: scale, y: scale))
    }
    
    func scaled(to size: CGSize) -> CIImage  {
        let scaleX = size.width / self.extent.width
        let scaleY = size.height / self.extent.height
        return self.scaled(by: scaleX, y: scaleY)
    }
    
    func withModifiers(_ modifiers: [Modifier]) -> CIImage {
        modifiers.reduce(self) { resultImage, modifier in
            modifier.modify(resultImage)
        }
    }
    
    func scaled(by x: CGFloat, y: CGFloat) -> CIImage {
        transformed(by: CGAffineTransform(scaleX: x, y: y))
    }
    
    func rotated(by rotation: CGFloat) -> CIImage {
        transformed(by: CGAffineTransform(rotationAngle: rotation))
    }
    
    func cropped(to size: CGSize) -> CIImage {
        self.cropped(to: .init(
            x: (extent.width - size.width) / 2,
            y: (extent.height - size.height) / 2,
            width: size.width,
            height: size.height
        ))
        .translatedToZero()
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
        
        return croppedImage.translatedToZero()
    }
    
    func scaledAroundCenter(by scale: CGFloat) -> CIImage {
        scaledAroundCenter(by: scale, y: scale)
    }
    
    func scaledAroundCenter(by x: CGFloat, y: CGFloat) -> CIImage {
        let centerPoint = CGPoint(
            x: extent.minX + extent.width / 2,
            y: extent.minY + extent.height / 2
        )
        
        let result = self
            .translated(by: -extent.minX, y: -extent.minY)
            .scaled(by: x, y: y)
        
        return result.translated(
            by: centerPoint.x - result.extent.width / 2,
            y: centerPoint.y - result.extent.height / 2
        )
    }
    
    func rotatedAroundCenter(by rotation: CGFloat) -> CIImage {
        let centerPoint = CGPoint(
            x: extent.minX + extent.width / 2,
            y: extent.minY + extent.height / 2
        )
        
        return self.translated(by: -centerPoint.x, y:  -centerPoint.y)
            .rotated(by: rotation)
            .translated(by: centerPoint.x, y:  centerPoint.y)
    }
    
    func blurred(with radius: CGFloat) -> CIImage {
        let blurFilter = CIFilter.gaussianBlur()
        blurFilter.inputImage = self
        blurFilter.radius = Float(radius)
        
        return blurFilter.outputImage?.cropped(to: self.extent) ?? self
    }
    
    func translatedToZero() -> CIImage {
        self.translated(by: -extent.minX, y: -extent.minY)
    }
}


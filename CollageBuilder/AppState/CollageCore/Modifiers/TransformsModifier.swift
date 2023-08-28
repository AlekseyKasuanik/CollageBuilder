//
//  TransformsModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 27.08.2023.
//

import SwiftUI

final class TransformsModifier: Modifier {
    
    var fitSize: CGSize {
        didSet { ciCash.clear()}
    }
    
    var fullSize: CGSize {
        didSet { ciCash.clear()}
    }
    
    var transforms: MediaTransforms {
        didSet { ciCash.clear()}
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    
    init(transforms: MediaTransforms,
         fitSize: CGSize,
         fullSize: CGSize) {
        
        self.transforms = transforms
        self.fitSize = fitSize
        self.fullSize = fullSize
    }
    
    func modify(_ image: CIImage) -> CIImage {
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let transformedImage = applyTransforms(to: image)
        ciCash.update(transformedImage, for: image.hash)
        
        return transformedImage
    }
    
    private func applyTransforms(to image: CIImage) -> CIImage {
        
        let scale = min(image.extent.width / fitSize.width,
                        image.extent.height / fitSize.height)
        
        let scaledImage = image.scaled(by: 1 / scale * transforms.scale)
        let rotatedImage = scaledImage.rotatedAroundCenter(by: -transforms.rotaion)
        
        let translatedImage = rotatedImage.translated(
            by: transforms.translation.x * fullSize.width,
            y: -transforms.translation.y * fullSize.height
        ).composited(over: CIImage.clear.cropped(to: scaledImage.extent))
        
        let croppedImage = translatedImage.cropped(to: .init(
            x: (scaledImage.extent.width - fitSize.width) / 2,
            y: (scaledImage.extent.height - fitSize.height) / 2,
            width: fitSize.width,
            height: fitSize.height
        ))
        
        return croppedImage
    }
}

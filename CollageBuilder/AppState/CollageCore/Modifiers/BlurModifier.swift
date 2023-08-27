//
//  BlurModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.08.2023.
//

import SwiftUI

final class BlurModifier: Modifier {
    
    var blur: Blur {
        didSet { ciCash.clear()}
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    
    init(blur: Blur) {
        self.blur = blur
    }
    
    func modify(_ image: CIImage) -> CIImage {
        guard blur != .none else {
            return image
        }
        
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let bluredImage = applyBlur(to: image)
        ciCash.update(bluredImage, for: image.hash)
        
        return bluredImage
    }
    
    private func applyBlur(to image: CIImage) -> CIImage {
        guard let filter = blur.createFilter(input: image) else {
            return image
        }
        
        let blurredImage = filter.outputImage
        let croppedImage = blurredImage?.cropped(to: image.extent)
        
        return croppedImage ?? image
    }
    
}

//
//  BlurModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.08.2023.
//

import SwiftUI

final class BlurModifier: Modifier {
    
    var context: CIContext
    var blur: Blur {
        didSet { claerHash() }
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    private var uiCash = CashManager<Int, UIImage>()
    
    init(context: CIContext, blur: Blur) {
        self.context = context
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
    
    func modify(_ image: UIImage) -> UIImage {
        guard blur != .none else {
            return image
        }
        
        if let cashImage = uiCash.getValue(for: image.hash) {
            return cashImage
        }
        
        guard let ciImage = image.imageCI else {
            return image
        }
        
        let bluredCIImage = modify(ciImage)
        let bluredImage = UIImage(ciImage: bluredCIImage,
                                  context: context)
        
        uiCash.update(bluredImage, for: image.hash)
        
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
    
    private func claerHash() {
        uiCash.clear()
        ciCash.clear()
    }
}

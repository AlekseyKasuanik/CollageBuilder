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
    
    private var ciHash: Int?
    private var ciCashImage: CIImage?
    
    private var uiHash: Int?
    private var uiCashImage: UIImage?
    
    init(context: CIContext, blur: Blur) {
        self.context = context
        self.blur = blur
    }
    
    func modify(_ image: CIImage) -> CIImage {
        guard blur != .none else {
            return image
        }
        
        if image.hash == ciHash, let ciCashImage {
            return ciCashImage
        }
        
        let bluredImage = applyBlur(to: image)
        ciCashImage = bluredImage
        ciHash = image.hash
        
        return bluredImage
    }
    
    func modify(_ image: UIImage) -> UIImage {
        guard blur != .none else {
            return image
        }
        
        if image.hash == uiHash, let uiCashImage {
            return uiCashImage
        }
        
        guard let ciImage = image.imageCI else {
            return image
        }
        
        let bluredCIImage = modify(ciImage)
        let bluredImage = UIImage(ciImage: bluredCIImage,
                                  context: context)
        
        uiCashImage = bluredImage
        uiHash = image.hash
        
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
        ciHash = nil
        uiHash = nil
        
        ciCashImage = nil
        uiCashImage = nil
    }
}


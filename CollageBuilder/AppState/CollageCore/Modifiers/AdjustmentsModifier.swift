//
//  AdjustmentsModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 23.08.2023.
//

import SwiftUI

final class AdjustmentsModifier: Modifier {
    
    var context: CIContext
    var adjustments: Adjustments {
        didSet { claerHash() }
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    private var uiCash = CashManager<Int, UIImage>()
    
    init(context: CIContext, adjustments: Adjustments) {
        self.context = context
        self.adjustments = adjustments
    }
    
    func modify(_ image: CIImage) -> CIImage {
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let imageWitchColorControls = applyColorControls(to: image)
        
        
        ciCash.update(imageWitchColorControls, for: image.hash)
        
        return image
    }
    
    func modify(_ image: UIImage) -> UIImage {
        if let cashImage = uiCash.getValue(for: image.hash) {
            return cashImage
        }
        
        guard let ciImage = image.imageCI else {
            return image
        }
        
        let imageWitchColorControls = applyColorControls(to: ciImage)
        
        let resultImage = UIImage(ciImage: imageWitchColorControls,
                                  context: context)
        
        uiCash.update(resultImage, for: image.hash)
        
        return image
    }
    
    private func applyColorControls(to image: CIImage) -> CIImage {
        let controls = adjustments.colorControls
        guard controls.brightness.current != controls.brightness.initial ||
                controls.saturation.current != controls.saturation.initial ||
                controls.contrast.current != controls.contrast.initial else {
            return image
        }
           
        let controlsFilter = CIFilter.colorControls()
        controlsFilter.inputImage = image
        controlsFilter.brightness = Float(controls.brightness.current)
        controlsFilter.saturation = Float(controls.saturation.current)
        controlsFilter.contrast = Float(controls.contrast.current)
        
        let resultImage = controlsFilter.outputImage ?? image
        
        return resultImage
    }
    
    private func claerHash() {
        uiCash.clear()
        ciCash.clear()
    }
}


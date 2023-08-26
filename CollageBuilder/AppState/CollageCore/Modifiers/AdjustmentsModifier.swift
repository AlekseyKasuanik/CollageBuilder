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
        didSet { ciCash.clear() }
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    
    init(context: CIContext, adjustments: Adjustments) {
        self.context = context
        self.adjustments = adjustments
    }
    
    func modify(_ image: CIImage) -> CIImage {
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let imageWithColorControls = applyColorControls(to: image)
        let imageWithExposure = applyExposure(to: imageWithColorControls)
        let imageWithGamma = applyGamma(to: imageWithExposure)
        let imageWithHue = applyHue(to: imageWithGamma)
        let imageWithTemperatureAndTint = applyTemperatureAndTint(to: imageWithHue)
        let imageWithVibrance = applyVibrance(to: imageWithTemperatureAndTint)
        
        ciCash.update(imageWithVibrance, for: image.hash)
        
        return imageWithVibrance
    }
    
    private func applyColorControls(to image: CIImage) -> CIImage {
        guard adjustments.brightness.current != adjustments.brightness.initial ||
                adjustments.saturation.current != adjustments.saturation.initial ||
                adjustments.contrast.current != adjustments.contrast.initial else {
            return image
        }
           
        let controlsFilter = CIFilter.colorControls()
        controlsFilter.inputImage = image
        controlsFilter.brightness = Float(adjustments.brightness.current)
        controlsFilter.saturation = Float(adjustments.saturation.current)
        controlsFilter.contrast = Float(adjustments.contrast.current)
        
        return controlsFilter.outputImage ?? image
    }
    
    private func applyExposure(to image: CIImage) -> CIImage {
        guard adjustments.exposure.current != adjustments.exposure.initial else {
            return image
        }
           
        let exposureFilter = CIFilter.exposureAdjust()
        exposureFilter.inputImage = image
        exposureFilter.ev = Float(adjustments.exposure.current)
        
        return exposureFilter.outputImage ?? image
    }
    
    private func applyGamma(to image: CIImage) -> CIImage {
        guard adjustments.gamma.current != adjustments.gamma.initial else {
            return image
        }
           
        let gammaFilter = CIFilter.gammaAdjust()
        gammaFilter.inputImage = image
        gammaFilter.power = Float(adjustments.gamma.current)
        
        return gammaFilter.outputImage ?? image
    }
    
    private func applyHue(to image: CIImage) -> CIImage {
        guard adjustments.hue.current != adjustments.hue.initial else {
            return image
        }
           
        let hueFilter = CIFilter.hueAdjust()
        hueFilter.inputImage = image
        hueFilter.angle = Float(adjustments.hue.current)
        
        return hueFilter.outputImage ?? image
    }
    
    private func applyTemperatureAndTint(to image: CIImage) -> CIImage {
        guard adjustments.temperature.current != adjustments.temperature.initial ||
                adjustments.tint.current != adjustments.tint.initial else {
            return image
        }
        
        let temperatureAndTintFilter = CIFilter.temperatureAndTint()
        temperatureAndTintFilter.inputImage = image
        temperatureAndTintFilter.targetNeutral = CIVector(
            x: adjustments.temperature.current,
            y: adjustments.tint.current
        )
        
        return temperatureAndTintFilter.outputImage ?? image
    }
    
    private func applyVibrance(to image: CIImage) -> CIImage {
        guard adjustments.vibrance.current != adjustments.vibrance.initial else {
            return image
        }
           
        let vibranceFilter = CIFilter.vibrance()
        vibranceFilter.inputImage = image
        vibranceFilter.amount = Float(adjustments.vibrance.current)
        
        return vibranceFilter.outputImage ?? image
    }
    
}


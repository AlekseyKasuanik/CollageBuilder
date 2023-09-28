//
//  BackgroundRemoval.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 26.09.2023.
//

import SwiftUI
import Vision

protocol BackgroundRemovalProtocol {
    func crateMask(for image: UIImage) async throws -> UIImage?
}

struct BackgroundRemoval: BackgroundRemovalProtocol {
    
    let context: CIContext
    
    func crateMask(for image: UIImage) async throws -> UIImage? {
        guard let ciImage = image.imageCI else { return nil }
        
        let request = VNGeneratePersonSegmentationRequest()
        request.qualityLevel = .accurate
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        try! handler.perform([request])
        
        guard let pixelBuffer = request.results?.first?.pixelBuffer else {
            return nil
        }
        
        let mask = CIImage(cvPixelBuffer: pixelBuffer)
            .scaled(to: ciImage.extent.size)
            .toAlphaMask()
        
        let uiIMage = UIImage(ciImage: mask, context: context)
        
        return uiIMage
        
    }
}

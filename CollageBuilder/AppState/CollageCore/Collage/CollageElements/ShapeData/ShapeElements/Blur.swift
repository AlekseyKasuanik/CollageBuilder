//
//  Blur.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.08.2023.
//

import CoreImage

enum Blur: Codable, Equatable {
    
    case box(CGFloat)
    case disc(CGFloat)
    case gaussian(CGFloat)
    case motion(CGFloat, angle: CGFloat)
    case none
    
    func createFilter(input: CIImage) -> CIFilter?  {
        switch self {
        case .box(let radius):
            let filter = CIFilter.boxBlur()
            filter.radius = Float(radius)
            filter.inputImage = input
            return filter
            
        case .disc(let radius):
            let filter = CIFilter.discBlur()
            filter.radius = Float(radius)
            filter.inputImage = input
            return filter
            
        case .gaussian(let radius):
            let filter = CIFilter.gaussianBlur()
            filter.radius = Float(radius)
            filter.inputImage = input
            return filter
            
        case .motion(let radius, let angle):
            let filter = CIFilter.motionBlur()
            filter.radius = Float(radius)
            filter.angle = Float(angle)
            filter.inputImage = input
            return filter
            
        case .none:
            return nil
        }
    }
    
}

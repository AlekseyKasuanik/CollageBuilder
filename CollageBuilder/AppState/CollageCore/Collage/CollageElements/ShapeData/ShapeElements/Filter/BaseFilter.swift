//
//  BaseFilter.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage.CIFilterBuiltins

struct BaseFilter: ColorFilter {
    let name: String
    let filter: BaseFilter
    
    func apply(to image: CIImage) -> CIImage {
        let filter = filter.createFilter(input: image)
        return filter.outputImage ?? image
    }
    
}

extension BaseFilter {
    enum BaseFilter: Codable {
        case photoEffectChrome, photoEffectFade, photoEffectInstant,
             photoEffectNoir, photoEffectProcess, photoEffectTonal,
             photoEffectTransfer
        
        
        func createFilter(input: CIImage) -> CIFilter {
            switch self {
            case .photoEffectChrome:
                let filter = CIFilter.photoEffectChrome()
                filter.inputImage = input
                return filter
                
            case .photoEffectFade:
                let filter = CIFilter.photoEffectFade()
                filter.inputImage = input
                return filter
                
            case .photoEffectInstant:
                let filter = CIFilter.photoEffectInstant()
                filter.inputImage = input
                return filter
                
            case .photoEffectNoir:
                let filter = CIFilter.photoEffectNoir()
                filter.inputImage = input
                return filter
                
            case .photoEffectProcess:
                let filter = CIFilter.photoEffectProcess()
                filter.inputImage = input
                return filter
                
            case .photoEffectTonal:
                let filter = CIFilter.photoEffectTonal()
                filter.inputImage = input
                return filter
                
            case .photoEffectTransfer:
                let filter = CIFilter.photoEffectTransfer()
                filter.inputImage = input
                return filter
            }
        }
    }
}

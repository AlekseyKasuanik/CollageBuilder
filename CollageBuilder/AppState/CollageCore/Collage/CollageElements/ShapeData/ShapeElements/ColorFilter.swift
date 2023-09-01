//
//  ColorFilter.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage
import SwiftUI

struct ColorFilter: Codable {
    let name: String
    let type: FilterType
    let id: String
    
    func apply(to image: CIImage) -> CIImage {
        let filter = type.createFilter(input: image)
        return filter.outputImage ?? image
    }
}

extension ColorFilter: Equatable {
    static func ==(lhs: ColorFilter, rhs: ColorFilter) -> Bool {
        lhs.id == rhs.id
    }
}

extension ColorFilter {
    init(name: String, type: FilterType) {
        self.init(name: name, type: type, id: UUID().uuidString)
    }
    
    init?(name: String, cubeImage: UIImage) {
        guard let type = FilterType(cubeImage: cubeImage) else {
            return nil
        }
        
        self.init(name: name, type: type)
    }
}

extension ColorFilter {
    enum FilterType: Codable {
        private static let cubeDimension = 16
        
        case cube(Data)
        case photoEffectChrome, photoEffectFade, photoEffectInstant,
             photoEffectNoir, photoEffectProcess, photoEffectTonal,
             photoEffectTransfer
        
        init?(cubeImage: UIImage) {
            guard let data = Self.extractCubeData(from: cubeImage) else {
                return nil
            }
            
            self = .cube(data)
        }
        
        
        func createFilter(input: CIImage) -> CIFilter {
            switch self {
            case .cube(let data):
                let filter = CIFilter.colorCube()
                filter.inputImage = input
                filter.cubeData = data
                filter.cubeDimension = Float(Self.cubeDimension)
                return filter
                
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
        
        private static func extractCubeData(from image: UIImage) -> Data? {
            let pixelsCount = Int(pow(Double(cubeDimension), 3))
            let bytesCount = pixelsCount * 4
            
            guard let cgImage = image.cgImage,
                  let data = cgImage.dataProvider?.data,
                  let dataPointer = CFDataGetBytePtr(data),
                  cgImage.width * cgImage.height == pixelsCount else {
                return nil
            }
            
            let cube = UnsafeMutablePointer<Float>.allocate(capacity: bytesCount)
            
            for i in 0..<bytesCount {
                cube[i] = (Float(dataPointer[i])) / 255.0
            }
            
            let cubeData = Data(
                bytesNoCopy: cube,
                count: bytesCount * MemoryLayout<Float>.size,
                deallocator: .free
            )
            
            return cubeData
        }
    }
}

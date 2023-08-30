//
//  CustomFilter.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage
import SwiftUI

struct CustomFilter: ColorFilter {
    let name: String
    let cubeData: Data
    
    private static let cubeDimension = 16
    
    func apply(to image: CIImage) -> CIImage {
        let filter = CIFilter.colorCube()
        filter.inputImage = image
        filter.cubeData = cubeData
        filter.cubeDimension = Float(Self.cubeDimension)
        
        return filter.outputImage ?? image
    }
    
}

extension CustomFilter {
    
    init?(name: String, image: UIImage) {
        guard let data = Self.extractCubeData(from: image) else {
            return nil
        }
        
        self.name = name
        self.cubeData = data
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

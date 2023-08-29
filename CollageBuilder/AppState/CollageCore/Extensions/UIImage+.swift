//
//  UIImage+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

extension UIImage: DataRepresentable {
    
    func getData() -> Data? {
        pngData()
    }
    
    static func create(from data: Data) -> UIImage? {
        UIImage(data: data)
    }
    
    var imageCI: CIImage? {
        if let ciImage {
            return ciImage
        } else if let cgImage {
            return CIImage(cgImage: cgImage)
                .oriented(.init(imageOrientation))
        } else {
            return nil
        }
    }
    
    convenience init(ciImage: CIImage, context: CIContext?) {
        if let context,
           let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            self.init(cgImage: cgImage)
        } else {
            self.init(ciImage: ciImage)
        }
    }
    
    func resize(to size: CGSize, with scale: CGFloat = 1) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            draw(in: .init(origin: .zero, size: size))
        }
    }
    
}

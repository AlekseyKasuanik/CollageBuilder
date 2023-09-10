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
    
    convenience init(ciImage: CIImage,
                     context: CIContext?,
                     scale: CGFloat = 1,
                     orientation: UIImage.Orientation = .up) {
        
        if let context,
           let cgImage = context.createCGImage(ciImage, from: ciImage.extent) {
            self.init(cgImage: cgImage,
                      scale: scale,
                      orientation: orientation)
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
    
    static func create(from color: UIColor,
                       size: CGSize = CGSize(width: 1, height: 1),
                       scale: CGFloat = 1) -> UIImage {
        
        let format = UIGraphicsImageRendererFormat()
        format.scale = scale
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            color.setFill()
        }
    }
    
    func masked(_ mask: UIImage) -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = self.scale
        
        return UIGraphicsImageRenderer(size: size, format: format).image { _ in
            self.draw(at: .zero)
            mask.draw(at: .zero, blendMode: .destinationOut, alpha: 1)
        }
    }
    
}

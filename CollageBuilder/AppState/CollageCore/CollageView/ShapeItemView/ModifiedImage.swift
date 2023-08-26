//
//  ModifiedImage.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 22.08.2023.
//

import SwiftUI

struct ModifiedImage: View {
    
    var modifiers: [Modifier]
    var image: UIImage
    var size: CGSize
    
    let context: CIContext
    
    @State private var scaledImage: CIImage?
    
    var body: some View {
        ZStack {
            if let uiImage {
                Image(uiImage: uiImage)
            } else {
                Image(uiImage: image)
            }
        }
        .onChange(of: image) { _ in setupScaledIamge() }
        .onAppear { setupScaledIamge() }
    }
    
    private var scale: CGFloat { UIScreen.current?.scale ?? 3 }
    
    private var uiImage: UIImage? {
        guard let modifiedImage = scaledImage?.withModifiers(modifiers),
              let cgImage = context.createCGImage(
                modifiedImage,
                from: modifiedImage.extent
              ) else {
            return nil
        }
        
        let uiImage = UIImage(cgImage: cgImage,
                              scale: scale,
                              orientation: .up)
        return uiImage
    }
    
    private func setupScaledIamge() {
        let correctSize = size * scale
        scaledImage = image.imageCI?.croppedAndScaled(to: correctSize)
    }
    
}

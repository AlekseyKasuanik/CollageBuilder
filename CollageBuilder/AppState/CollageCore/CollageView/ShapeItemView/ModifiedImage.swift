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
    
    @State private var ciImage: CIImage?
    
    var body: some View {
        ZStack {
            if let uiImage {
                Image(uiImage: uiImage)
            } else {
                Image(uiImage: image)
            }
        }
        .onAppear { ciImage = image.imageCI }
        .onChange(of: image) {
            ciImage = $0.imageCI
        }
    }
    
    private var uiImage: UIImage? {
        guard let modifiedImage = ciImage?.withModifiers(modifiers) else {
            return nil
        }
        
        let image = UIImage(
            ciImage: modifiedImage,
            context: context,
            scale: screenScale
        )
        
        return image
    }
    
}

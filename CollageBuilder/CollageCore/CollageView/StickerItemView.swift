//
//  StickerItemView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import SwiftUI

struct StickerItemView: View {
    
    var sticker: Sticker
    var collageSize: CGSize
    var isPlaying: Bool
    
    var strokeColor: UIColor
    var strokeWidth: CGFloat
    
    var body: some View {
        Image(uiImage: image)
            .resizable()
            .blendMode(sticker.blendMode.blendMode)
            .frame(width: sticker.relativeInitialSize.width * collageSize.width,
                   height: sticker.relativeInitialSize.height * collageSize.height)
            .rotationEffect(.radians(sticker.transforms.rotation))
            .scaleEffect(sticker.transforms.scale)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(strokeColor), lineWidth: strokeWidth)
            }
            .frameAnimation(animate: isPlaying,
                            animation: sticker.animation)
            .position(x: collageSize.width * sticker.transforms.position.x,
                      y: collageSize.height * sticker.transforms.position.y)
            .zIndex(Double(sticker.zPosition))
    }
    
    var image: UIImage {
        guard let mask = sticker.mask else {
            return sticker.image
        }
        
        return sticker.image.masked(mask)
    }
}

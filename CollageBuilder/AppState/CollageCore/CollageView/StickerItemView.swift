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
    
    var strokeColor: UIColor
    var strokeWidth: CGFloat
    
    var body: some View {
        Image(uiImage: sticker.image)
            .resizable()
            .frame(width: sticker.relativeInitialSize.width * collageSize.width,
                   height: sticker.relativeInitialSize.height * collageSize.height)
            .overlay {
                RoundedRectangle(cornerRadius: 10)
                    .stroke(Color(strokeColor), lineWidth: strokeWidth)
            }
            .rotationEffect(.radians(sticker.transforms.rotation))
            .scaleEffect(sticker.transforms.scale)
            .position(x: collageSize.width * sticker.transforms.position.x,
                      y: collageSize.height * sticker.transforms.position.y)
            .blendMode(sticker.blendMode.blendMode)
            .zIndex(Double(sticker.zPosition))
    }
}

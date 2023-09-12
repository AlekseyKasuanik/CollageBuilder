//
//  TextItemView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 05.09.2023.
//

import SwiftUI

struct TextItemView: View {
    
    var settings: TextSettings
    var collageSize: CGSize
    
    var strokeColor: UIColor
    var strokeWidth: CGFloat
    
    var body: some View {
        TextView(settings: .constant(settings))
            .blendMode(settings.blendMode.blendMode)
            .frame(width: settings.size.width,
                   height: settings.size.height)
            .rotationEffect(.radians(settings.transforms.rotation))
            .scaleEffect(settings.transforms.scale)
            .overlay {
                RoundedRectangle(cornerRadius: settings.cornerRadius)
                    .stroke(Color(strokeColor), lineWidth: strokeWidth)
            }
            .position(x: collageSize.width * settings.transforms.position.x,
                      y: collageSize.height * settings.transforms.position.y)
            .zIndex(Double(settings.zPosition))
        
    }
}

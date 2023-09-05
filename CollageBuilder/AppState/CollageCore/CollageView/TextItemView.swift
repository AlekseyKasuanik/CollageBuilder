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
    
    var body: some View {
        TextView(settings: .constant(settings))
            .frame(width: settings.size.width,
                   height: settings.size.height)
            .rotationEffect(.radians(settings.transforms.rotation))
            .scaleEffect(settings.transforms.scale)
            .position(x: collageSize.width * settings.transforms.position.x,
                      y: collageSize.height * settings.transforms.position.y)
            .zIndex(Double(settings.zPosition))
    }
}

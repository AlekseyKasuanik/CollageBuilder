//
//  MediaView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import SwiftUI
import AVFoundation

struct MediaView: View {
    
    var media: Media?
    var modifiers: [Modifier]
    var size: CGSize
    var emptyColor: UIColor
    var isPlaying: Bool
    
    @State private var videoImage: UIImage?
    
    var body: some View {
        switch media?.resource {
        case .image(let image):
            ModifiedImage(
                modifiers: modifiers,
                image: image,
                size: size,
                context: SharedContext.context
            )
            
        case .video(let video):
            VideoPlayerView(videoURL: video.videoUrl,
                            modifiers: modifiers,
                            settings: video.settings,
                            isPlaying: isPlaying,
                            context: SharedContext.context)
            
        case .color(let color):
            Color(uiColor: color)
            
        case .none:
            Color(uiColor: emptyColor)
        }
    }
}

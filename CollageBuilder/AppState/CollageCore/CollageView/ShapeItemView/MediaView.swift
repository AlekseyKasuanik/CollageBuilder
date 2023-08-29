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
        if let media {
            switch media.resource {
            case .image(let image):
                ModifiedImage(
                    modifiers: modifiers,
                    image: image,
                    size: size,
                    context: SharedContext.context
                )
                
            case .video(let video):
                ZStack {
                    if let videoImage {
                        ModifiedImage(
                            modifiers: modifiers,
                            image: videoImage,
                            size: size,
                            context: SharedContext.context
                        )
                        .opacity(isPlaying ? 0 : 1)
                    }
                    
                    VideoPlayerView(videoURL: video.videoUrl,
                                    modifiers: modifiers,
                                    settings: .defaultSettings,
                                    isPlaying: isPlaying,
                                    context: SharedContext.context)
                    .opacity(isPlaying ? 1 : 0)
                }
                .task {
                    await setupVideoImage(for: video.videoUrl, scale: screenScale)
                }

            case .color(let color):
                Color(uiColor: color)
            }
        } else {
            Color(uiColor: emptyColor)
        }
    }
    
    private func setupVideoImage(for url: URL, scale: CGFloat) async {
        let asset = AVURLAsset(url: url)
        guard let image = await asset.firstImage else {
            return
        }
        
        let targetSize = image.size.fill(size * scale)
        let scaledImage = image.resize(to: targetSize)
        
        videoImage = scaledImage
    }
}

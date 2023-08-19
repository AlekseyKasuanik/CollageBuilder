//
//  CollageBackgroundView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import SwiftUI

struct CollageBackgroundView: View {
    
    let background: CollageBackground
    
    var body: some View {
        switch background {
        case .image(let image):
            Image(uiImage: image)
                .resizable()
                .scaledToFill()
        case .video(let video):
            VideoPlayerView(videoURL: video.videoUrl,
                            modifiers: [],
                            settings: .defaultSettings)
        case .color(let color):
            Color(uiColor: color)
        }
    }
}

struct CollageBackgroundView_Previews: PreviewProvider {
    static var previews: some View {
        CollageBackgroundView(background: .color(.white))
    }
}

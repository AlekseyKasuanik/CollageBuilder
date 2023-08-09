//
//  VideoPlayerView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    let videoURL: URL
    let modifiers: [Modifier]
    
    func makeUIView(context: Context) -> some UIView {
        
        let videoPlayer = VideoPlayer(videoURL: videoURL, modifiers: modifiers)
        videoPlayer.play()
        return videoPlayer
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {}
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoURL: Bundle.main.url(forResource: "ExampleVideo",
                                                  withExtension: "mp4")!,
                        modifiers: [])
    }
}

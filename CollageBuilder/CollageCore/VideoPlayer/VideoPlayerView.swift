//
//  VideoPlayerView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import SwiftUI

struct VideoPlayerView: UIViewRepresentable {
    
    var videoURL: URL
    var modifiers: [Modifier]
    var settings: VideoSettings
    var isPlaying: Bool
    var restartAfterPause = true
    
    let context: CIContext
    
    func makeUIView(context: Context) -> VideoPlayer {
        let videoPlayer = VideoPlayer(videoURL: videoURL,
                                      modifiers: modifiers,
                                      settings: settings,
                                      context: self.context)
        
        if isPlaying { videoPlayer.play() }
        return videoPlayer
    }
    
    func updateUIView(_ uiView: VideoPlayer, context: Context) {
        uiView.modifiers = modifiers
        uiView.changeSettings(settings)
        if isPlaying {
            uiView.play()
        } else {
            uiView.pause()
            if restartAfterPause { uiView.restart() }
        }
    }
}

struct VideoPlayerView_Previews: PreviewProvider {
    static var previews: some View {
        VideoPlayerView(videoURL: Bundle.main.url(forResource: "ExampleVideo",
                                                  withExtension: "mp4")!,
                        modifiers: [],
                        settings: .defaultSettings,
                        isPlaying: true,
                        context: CIContext())
    }
}

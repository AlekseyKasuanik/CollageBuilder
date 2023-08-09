//
//  VideoPlayer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import AVFoundation
import SwiftUI
import CoreImage.CIFilterBuiltins

final class VideoPlayer: UIView {
    
    private let asset: AVURLAsset
    private let playerLooper: AVPlayerLooper
    private let queuePlayer: AVQueuePlayer
    private let playerItem: AVPlayerItem
    private let videoLayer: AVPlayerLayer
    
    private var videoSize: CGSize?
    
    var modifiers: [Modifier]
    
    init(videoURL: URL, modifiers: [Modifier]) {
        
        self.asset = AVURLAsset(url: videoURL)
        self.modifiers = modifiers
        
        self.playerItem = AVPlayerItem(asset: asset)
        self.queuePlayer = AVQueuePlayer(playerItem: playerItem)
        self.playerLooper = AVPlayerLooper(player: queuePlayer, templateItem: playerItem)
        self.videoLayer = AVPlayerLayer(player: queuePlayer)
        
        super.init(frame: .zero)
        
        self.layer.addSublayer(videoLayer)
        self.layer.masksToBounds = true
        
        Task { await self.setupVideoSize(for: asset) }
        self.setupCompostion()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setCorrectFrameToVideoLayer()
    }
    
    func play() {
        queuePlayer.play()
    }
    
    func pause() {
        queuePlayer.pause()
    }
    
    private func setupCompostion() {
        playerItem.videoComposition = AVMutableVideoComposition(asset: asset) { request in
            request.finish(with: self.applyModifiers(to: request.sourceImage),
                           context: SharedContext.contect)
        }
    }
    
    private func applyModifiers(to image: CIImage) -> CIImage {
        modifiers.reduce(image) { resultImage, modifier in
            modifier.modify(resultImage)
        }
    }
    
    private func setupVideoSize(for asset: AVURLAsset) async {
        guard let tracks = try? await asset.loadTracks(withMediaType: .video),
              let track = tracks.first,
              let size = try? await track.load(.naturalSize) else {
            return
        }
        
        videoSize = size
        
        Task { @MainActor in
            setCorrectFrameToVideoLayer()
        }
    }
    
    private func setCorrectFrameToVideoLayer() {
        guard let videoSize else { return }
        
        let scale = max(frame.width / videoSize.width,
                        frame.height / videoSize.height)
        
        let videoWidth = videoSize.width * scale
        let videoHeight = videoSize.height * scale

        videoLayer.frame = CGRect(x: (frame.width - videoWidth) / 2,
                                  y: (frame.height - videoHeight) / 2,
                                  width: videoWidth,
                                  height: videoHeight)
    }
    
}


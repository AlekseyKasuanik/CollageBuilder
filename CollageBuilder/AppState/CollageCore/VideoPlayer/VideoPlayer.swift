//
//  VideoPlayer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import AVFoundation
import SwiftUI
import CoreImage.CIFilterBuiltins
import Combine

final class VideoPlayer: UIView {
    
    private let asset: AVURLAsset
    private let queuePlayer: AVQueuePlayer
    private let playerItem: AVPlayerItem
    private let videoLayer: AVPlayerLayer
    
    private var videoSize: CGSize?
    private var cancelable = Set<AnyCancellable>()
    
    private(set) var settings: VideoSettings

    var modifiers: [Modifier]
    
    init(videoURL: URL,
         modifiers: [Modifier],
         settings: VideoSettings) {
        
        self.asset = AVURLAsset(url: videoURL)
        self.modifiers = modifiers
        self.settings = settings
        
        playerItem = AVPlayerItem(asset: asset)
        queuePlayer = AVQueuePlayer(playerItem: playerItem)
        queuePlayer.actionAtItemEnd = .none
       
        videoLayer = AVPlayerLayer(player: queuePlayer)
        
        super.init(frame: .zero)
        
        layer.addSublayer(videoLayer)
        layer.masksToBounds = true
        
        Task { await setupVideoSize(for: asset) }
        
        setupCompostion()
        setutPlayerNotification()
        
        try? setupTrim()
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
    
    func changeSettings(_ settings: VideoSettings) {
        let oldSettings = self.settings
        self.settings = settings
        
        if oldSettings.trim != settings.trim {
            try? setupTrim()
        }
        
        if oldSettings.speed != settings.speed {
            setupSpeed()
        }
        
        if oldSettings.isMuted != settings.isMuted {
            setupMute()
        }
    }
    
    private func setupSpeed() {
        queuePlayer.rate = settings.speed
    }
    
    private func setupMute() {
        queuePlayer.isMuted = settings.isMuted
    }
    
    private func setupTrim() throws {
        Task {
        
            let duration = try await asset.load(.duration).seconds
            let trim = settings.trim ?? .init(start: 0, end: duration)
            
            await queuePlayer.seek(to: trim.startTime,
                                   toleranceBefore: .zero,
                                   toleranceAfter: .zero)
            
            queuePlayer.currentItem?.forwardPlaybackEndTime = trim.endTime
            queuePlayer.play()
        }
        
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
    
    private func setutPlayerNotification() {
        NotificationCenter.default.publisher(for: .AVPlayerItemDidPlayToEndTime)
            .sink { [weak self] player in
                guard let self,
                      let item = player.object as? AVPlayerItem,
                      item == playerItem else {
                    return
                }
                
                try? setupTrim()
            }
            .store(in: &cancelable)
    }
    
}


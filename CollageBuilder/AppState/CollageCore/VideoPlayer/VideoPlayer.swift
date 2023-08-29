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
    private let context: CIContext
    
    private var cancelable = Set<AnyCancellable>()
    
    private(set) var settings: VideoSettings
    
    var modifiers: [Modifier]
    
    init(videoURL: URL,
         modifiers: [Modifier],
         settings: VideoSettings,
         context: CIContext) {
        
        self.asset = AVURLAsset(url: videoURL)
        self.modifiers = modifiers
        self.settings = settings
        self.context = context
        
        playerItem = AVPlayerItem(asset: asset)
        queuePlayer = AVQueuePlayer(playerItem: playerItem)
        queuePlayer.actionAtItemEnd = .none
        
        videoLayer = AVPlayerLayer(player: queuePlayer)
        
        super.init(frame: .zero)
        
        layer.addSublayer(videoLayer)
        
        setupPlayerNotification()
        
        try? setupTrim()
        setupVideoLayer()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        videoLayer.frame = frame
        if frame.size != .zero {
            Task { await setupComposition(for: frame.size * screenScale) }
        }
    }
    
    func play() {
        setupMute()
        setupSpeed()
    }
    
    func restart() {
        try? setupTrim()
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
        }
        
    }
    
    private func setupComposition(for size: CGSize) async {
        guard let videoSize = await asset.videoSize else {
            return
        }
        
        let fillSize = videoSize.fill(size)
        let baseTranslation = CGPoint(
            x: (fillSize.width - size.width) / 2,
            y: (fillSize.height - size.height) / 2
        )
        
        let scale = max(size.width / videoSize.width,
                        size.width / videoSize.height)
        
        let composition = AVMutableVideoComposition(
            asset: asset
        ) { [weak self] request in
            guard let self else { return }
            
            let modifiedImage = request.sourceImage
                .withModifiers(self.modifiers)
                .translated(by: baseTranslation)
            
            request.finish(with: modifiedImage,
                           context: self.context)
        }
        
        composition.renderScale = Float(scale)
        playerItem.videoComposition = composition
    }
    
    private func setupPlayerNotification() {
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
    
    private func setupVideoLayer() {
        videoLayer.videoGravity = .resizeAspectFill
        videoLayer.backgroundColor = UIColor.clear.cgColor
        videoLayer.pixelBufferAttributes = [
            (kCVPixelBufferPixelFormatTypeKey as String) : kCVPixelFormatType_32BGRA
        ]
    }
}


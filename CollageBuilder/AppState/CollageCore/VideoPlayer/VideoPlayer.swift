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
    private var videoTrim: VideoTrim?
    private var cancelable = Set<AnyCancellable>()

    var modifiers: [Modifier]
    
    init(videoURL: URL,
         modifiers: [Modifier],
         videoTrim: VideoTrim?) {
        
        self.asset = AVURLAsset(url: videoURL)
        self.modifiers = modifiers
        self.videoTrim = videoTrim
        
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
    
    private func setupTrim() throws {
        Task {
            if videoTrim == nil {
                let duration = try await asset.load(.duration).seconds
                videoTrim = .init(start: 0, end: duration)
            }
            
            await queuePlayer.seek(to: videoTrim!.startTime, toleranceBefore: .zero, toleranceAfter: .zero)
            queuePlayer.currentItem?.forwardPlaybackEndTime = videoTrim!.endTime
            queuePlayer.play()
            queuePlayer.rate = 1.5
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


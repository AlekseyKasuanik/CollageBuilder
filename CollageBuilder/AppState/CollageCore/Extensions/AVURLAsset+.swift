//
//  AVURLAsset+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 28.08.2023.
//

import AVFoundation

extension AVURLAsset {
    
    var videoSize: CGSize? {
        get async {
            guard let tracks = try? await loadTracks(withMediaType: .video),
                  let track = tracks.first,
                  let size = try? await track.load(.naturalSize) else {
                return nil
            }
            return size
        }
    }
}

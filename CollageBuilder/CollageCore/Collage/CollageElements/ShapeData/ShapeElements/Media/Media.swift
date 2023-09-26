//
//  Media.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI
import AVFoundation

struct Media: Codable {
    
    @CodableWrapper var resource: Resource
    var maskSettings: MaskSettings?
    
    private(set) var id = UUID().uuidString
    
    var image: CIImage? {
        get async {
            switch resource {
            case .image(let image):
                return image.imageCI
                
            case .video(let video):
                let asset = AVURLAsset(url: video.videoUrl)
                return await asset.firstCIImage
                
            default:
                return nil
            }
        }
    }
    
    var videoSettings: VideoSettings? {
        get {
            guard case .video(let video) = resource else {
                return nil
            }
            return video.settings
        }
        
        set {
            guard case .video(var video) = resource,
                  let settings = newValue else {
                return
            }
            video.settings = settings
            resource = .video(video)
        }
    }
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        lhs.id == rhs.id && lhs.videoSettings == rhs.videoSettings
    }
}

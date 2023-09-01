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
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

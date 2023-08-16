//
//  CollageBackground.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import SwiftUI

enum CollageBackground {
    case image(UIImage)
    case video(Video)
    case color(UIColor)
    
    init(media: Media) {
        switch media.resource {
        case .image(let image):
            self = .image(image)
            
        case .video(let video):
            self = .video(video)
        }
    }
}

extension CollageBackground: DataRepresentable {
    
    func getData() -> Data? {
        switch self {
        case .image(let image):
            return image.getData()
            
        case .video(let video):
            return video.getData()
            
        case .color(let color):
            return color.getData()
        }
    }
    
    static func create(from data: Data) -> CollageBackground? {
        if let video = Video.create(from: data) {
            return .video(video)
            
        } else if let image = UIImage.create(from: data) {
            return .image(image)
            
        } else if let color = UIColor.create(from: data) {
            return .color(color)
            
        } else {
            return nil
        }
    }
    
}

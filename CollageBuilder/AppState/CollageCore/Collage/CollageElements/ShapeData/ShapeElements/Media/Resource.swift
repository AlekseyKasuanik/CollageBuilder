//
//  Resource.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import SwiftUI

enum Resource: DataRepresentable {
    
    case image(UIImage)
    case video(Video)
    case color(UIColor)
    
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
    
    static func create(from data: Data) -> Resource? {
        if let image = UIImage.create(from: data) {
            return .image(image)
            
        } else if let video = Video.create(from: data) {
            return .video(video)
            
        } else if let color = UIColor.create(from: data) {
            return .color(color)
            
        } else {
            return nil
        }
    }
}

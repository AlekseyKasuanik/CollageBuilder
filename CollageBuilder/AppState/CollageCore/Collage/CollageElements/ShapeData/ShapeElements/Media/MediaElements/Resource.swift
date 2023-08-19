//
//  Resource.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import SwiftUI

enum Resource: DataRepresentable {
    case image(UIImage), video(Video)
    
    func getData() -> Data? {
        switch self {
        case .image(let image):
            return image.getData()
        case .video(let video):
            return video.getData()
        }
    }
    
    static func create(from data: Data) -> Resource? {
        if let image = UIImage.create(from: data) {
            return .image(image)
        } else if let video = Video.create(from: data) {
            return .video(video)
        } else {
            return nil
        }
    }
}

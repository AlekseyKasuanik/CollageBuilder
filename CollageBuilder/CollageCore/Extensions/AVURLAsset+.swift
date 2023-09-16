//
//  AVURLAsset+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 28.08.2023.
//

import AVFoundation
import SwiftUI

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
    
    var firstCGImage: CGImage? {
        get async {
            let imageGenerator = AVAssetImageGenerator(asset: self)
            imageGenerator.appliesPreferredTrackTransform = true
            guard let image = try? await imageGenerator.image(at: .zero).image else {
                return nil
            }
            return image
        }
    }
    
    var firstUIImage: UIImage? {
        get async {
            guard let image = await firstCGImage else {
                return nil
            }
            
            return UIImage(cgImage: image)
        }
    }
    
    var firstCIImage: CIImage? {
        get async {
            guard let image = await firstCGImage else {
                return nil
            }
            
            return CIImage(cgImage: image)
        }
    }
    
    func createIterator(for times: [Double],
                        timescale: Int32 = 600) -> AVAssetImageGenerator.Images {
        
        let imageGenerator = AVAssetImageGenerator(asset: self)
        imageGenerator.appliesPreferredTrackTransform = true
        
        let cmTimes = times.map {
            CMTime(seconds: $0, preferredTimescale: timescale)
        }
        
        return imageGenerator.images(for: cmTimes).makeAsyncIterator()
    }
    
    func createImages(for times: [Double],
                      timescale: Int32 = 600) async -> [CGImage] {
        
        var images = [CGImage]()
        
        var iterator = createIterator(for: times, timescale: timescale)
        
        while let element = await iterator.next() {
            if let image = try? element.image {
                images.append(image)
            }
        }
        
        return images
    }
}


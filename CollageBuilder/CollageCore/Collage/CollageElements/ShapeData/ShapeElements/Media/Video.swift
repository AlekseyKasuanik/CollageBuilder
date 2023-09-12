//
//  Video.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 13.08.2023.
//

import SwiftUI

struct Video {
    let videoUrl: URL
    var settings: VideoSettings
}

extension Video: DataRepresentable {
    
    func getData() -> Data? {
        guard let data = try? Data(contentsOf: videoUrl),
              let videoData = try? JSONEncoder().encode(VideoData(
                url: videoUrl,
                data: data,
                settings: settings
              )) else {
            return nil
        }
        
        return videoData
    }
    
    static func create(from data: Data) -> Video? {
        guard let videoData = try? JSONDecoder().decode(
            VideoData.self,
            from: data
        ) else {
            return nil
        }
        
        try? saveDataifNeeded(videoData)
        
        let video = Video(videoUrl: videoData.url,
                          settings: videoData.settings)

        return video
    }
    
    private static func saveDataifNeeded(_ videoData: VideoData) throws {
        if !FileManager.default.fileExists(atPath: videoData.url.path()) {
            try videoData.data.write(to: videoData.url)
        }
    }
    
    private struct VideoData: Codable {
        let url: URL
        let data: Data
        let settings: VideoSettings
    }
    
}

extension Video: Transferable {
    static var transferRepresentation: some TransferRepresentation {
        FileRepresentation(contentType: .movie) { movie in
            SentTransferredFile(movie.videoUrl)
        } importing: { received in
            let copy = URL.cachesDirectory.appending(path: UUID().uuidString + ".mp4")

            if FileManager.default.fileExists(atPath: copy.path()) {
                try FileManager.default.removeItem(at: copy)
            }

            try FileManager.default.copyItem(at: received.file, to: copy)
            
            return Self.init(videoUrl: copy, settings: .defaultSettings)
        }
    }
}

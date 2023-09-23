//
//  AnimationsCreator.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.09.2023.
//

import Foundation

protocol AnimationsCreatorProtocol {
    func create(from url: URL) async -> AnimationSettings?
}

struct AnimationsCreator: AnimationsCreatorProtocol {
    
    private enum Constants {
        static let frameRate = 60
        static let componentsCount = 6
        static let opacityIndex = 1
        static let xTranslationIndex = 2
        static let yTranslationIndex = 3
        static let scaleIndex = 4
        static let rotationIndex = 5
    }
    
    func create(from url: URL) async -> AnimationSettings? {
        guard let frameSettings = try? await createFrames(for: url) else {
            return nil
        }
        
        let settings = AnimationSettings(frameRate: Constants.frameRate,
                                         frames: frameSettings)
        
        return settings
    }
    
    private func createFrames(for url: URL) async throws -> [AnimationFrameSettings] {
        var resultSettings = [AnimationFrameSettings]()
        
        for try await line in url.lines {
            let components = line
                .replacingOccurrences(of: ",", with: ".")
                .components(separatedBy: ";")
            
            if let settings = convert(components: components) {
                resultSettings.append(settings)
            }
        }
        
        return resultSettings
    }
    
    private func convert(components: [String]) -> AnimationFrameSettings? {
        guard components.count == Constants.componentsCount,
              let opacity = Double(components[Constants.opacityIndex]),
              let xTranslation = Double(components[Constants.xTranslationIndex]),
              let yTranslation = Double(components[Constants.yTranslationIndex]),
              let scale = Double(components[Constants.scaleIndex]),
              let rotation = Double(components[Constants.rotationIndex]) else {
            return nil
        }
        
        let frameSettings = AnimationFrameSettings(
            alpha: opacity,
            translation: .init(x: xTranslation, y: yTranslation),
            rotation: -rotation,
            scale: scale
        )
        
        return frameSettings
    }
}

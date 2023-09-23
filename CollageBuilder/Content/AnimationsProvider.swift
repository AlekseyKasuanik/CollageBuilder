//
//  AnimationsProvider.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 22.09.2023.
//

import Foundation

enum AnimationsProvider {
    
    static private let animationsCreator = AnimationsCreator()
    static private var animations: [AnimationData]?
    static var allAnimations: [AnimationData] {
        get async {
            guard let animations else {
                let createdAnimations = await createAnimations()
                animations = createdAnimations
                return createdAnimations
            }
            
            return animations
        }
    }
    
    static private func createAnimations() async -> [AnimationData] {
        let opacity = await animation(with: "opacity")!
        let rotation = await animation(with: "rotation")!
        let scaleAndRotation = await animation(with: "scaleAndRotation")!
        let scaleAndTranslationX = await animation(with: "scaleAndTranslationX")!
        let scaleAndTranslationY = await animation(with: "scaleAndTranslationY")!
        let strange = await animation(with: "strange")!
        let translationX = await animation(with: "translationX")!
        let translationY = await animation(with: "translationY")!
        
        let animations: [AnimationData] = [
            .init(name: "opacity", settings: opacity),
            .init(name: "rotation", settings: rotation),
            .init(name: "scaleAndRotation", settings: scaleAndRotation),
            .init(name: "scaleAndTranslationX", settings: scaleAndTranslationX),
            .init(name: "scaleAndTranslationY", settings: scaleAndTranslationY),
            .init(name: "strange", settings: strange),
            .init(name: "translationX", settings: translationX),
            .init(name: "translation", settings: translationY),
        ]
        
        return animations
    }
    
    private static func animation(with name: String) async -> AnimationSettings? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "csv"),
              let animation = await animationsCreator.create(from: url) else {
            return nil
        }
        
        return animation
    }
}

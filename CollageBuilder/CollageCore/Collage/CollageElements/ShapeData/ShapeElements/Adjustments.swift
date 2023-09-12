//
//  Adjustments.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 23.08.2023.
//

import Foundation

struct Adjustments: Codable, Equatable, Hashable {
    
    var saturation: AdjustmentValue
    var brightness: AdjustmentValue
    var contrast: AdjustmentValue
    var exposure: AdjustmentValue
    var gamma: AdjustmentValue
    var hue: AdjustmentValue
    var temperature: AdjustmentValue
    var tint: AdjustmentValue
    var vibrance: AdjustmentValue
    
    static var defaultAdjustments: Adjustments {
        .init(saturation: AdjustmentValue(min: 0, max: 2, initial: 1),
              brightness: AdjustmentValue(min: -1, max: 1, initial: 0),
              contrast: AdjustmentValue(min: 0.25, max: 4, initial: 1),
              exposure: AdjustmentValue(min: -10, max: 10, initial: 0),
              gamma: AdjustmentValue(min: 0.25, max: 4, initial: 1),
              hue: AdjustmentValue(min: -.pi, max: .pi, initial: 0),
              temperature: AdjustmentValue(min: 3500, max: 9500, initial: 6500),
              tint: AdjustmentValue(min: -100, max: 100, initial: 0),
              vibrance: AdjustmentValue(min: -1, max: 1, initial: 0))
    }
    
    
    struct AdjustmentValue: Codable, Equatable, Hashable {
        let min: CGFloat
        let max: CGFloat
        let initial: CGFloat
        var current: CGFloat
        
        init(min: CGFloat,
             max: CGFloat,
             initial: CGFloat,
             current: CGFloat? = nil) {
            
            self.min = min
            self.max = max
            self.initial = initial
            self.current = current ?? initial
        }
    }
}

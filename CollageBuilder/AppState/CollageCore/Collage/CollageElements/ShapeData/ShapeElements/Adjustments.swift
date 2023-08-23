//
//  Adjustments.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 23.08.2023.
//

import Foundation

struct Adjustments: Codable, Equatable {
    
    var colorControls: ColorControls
    
    static var defaultAdjustments: Adjustments {
        .init(colorControls: ColorControls())
    }
    
    struct ColorControls: Codable, Equatable {
        var saturation = AdjustmentValue(min: -1, maxValue: 1, initial: 1)
        var brightness = AdjustmentValue(min: 0, maxValue: 2, initial: 1)
        var contrast = AdjustmentValue(min: 0, maxValue: 4, initial: 1, current: 1)
    }
    
    struct AdjustmentValue: Codable, Equatable {
        let min: CGFloat
        let maxValue: CGFloat
        let initial: CGFloat
        var current: CGFloat
        
        init(min: CGFloat, maxValue: CGFloat, initial: CGFloat, current: CGFloat? = nil) {
            self.min = min
            self.maxValue = maxValue
            self.initial = initial
            self.current = current ?? initial
        }
    }
}

//
//  ContentBlendMode.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 14.08.2023.
//

import SwiftUI

enum ContentBlendMode: Codable {
    
    case normal
    case multiply
    case screen
    case overlay
    case darken
    case lighten
    case colorDodge
    case colorBurn
    case softLight
    case hardLight
    case difference
    case exclusion
    case hue
    case saturation
    case color
    case luminosity
    case sourceAtop
    case destinationOver
    case destinationOut
    
    var blendMode: BlendMode { convertToBlendMode() }
    var blendKernel: CIBlendKernel { converToKernel() }
    
    func apply(foreground: CIImage, background: CIImage) -> CIImage? {
        return blendKernel.apply(foreground: foreground, background: background)
    }
    
    private func convertToBlendMode() -> BlendMode {
        switch self {
        case .normal:
            return .normal
            
        case .multiply:
            return .multiply
            
        case .screen:
            return .screen
            
        case .overlay:
            return .overlay
            
        case .darken:
            return .darken
            
        case .lighten:
            return .lighten
            
        case .colorDodge:
            return .colorDodge
            
        case .colorBurn:
            return .colorBurn
            
        case .softLight:
            return .softLight
            
        case .hardLight:
            return .hardLight
            
        case .difference:
            return .difference
            
        case .exclusion:
            return .exclusion
            
        case .hue:
            return .hue
            
        case .saturation:
            return .saturation
            
        case .color:
            return .color
            
        case .luminosity:
            return .luminosity
            
        case .sourceAtop:
            return .sourceAtop
            
        case .destinationOver:
            return .destinationOver
            
        case .destinationOut:
            return .destinationOut
        }
    }
    
    private func converToKernel() -> CIBlendKernel {
        switch self {
        case .normal:
            return CIBlendKernel.sourceOver
            
        case .color:
            return CIBlendKernel.color
            
        case .colorBurn:
            return CIBlendKernel.colorBurn
            
        case .colorDodge:
            return CIBlendKernel.colorDodge
            
        case .darken:
            return CIBlendKernel.darken
            
        case .destinationOut:
            return CIBlendKernel.destinationOut
            
        case .destinationOver:
            return CIBlendKernel.destinationOver
            
        case .difference:
            return CIBlendKernel.difference
            
        case .exclusion:
            return CIBlendKernel.exclusion
            
        case .hardLight:
            return CIBlendKernel.hardLight
            
        case .hue:
            return CIBlendKernel.hue
            
        case .lighten:
            return CIBlendKernel.lighten
            
        case .luminosity:
            return CIBlendKernel.luminosity
            
        case .multiply:
            return CIBlendKernel.multiply
            
        case .overlay:
            return CIBlendKernel.overlay
            
        case .saturation:
            return CIBlendKernel.saturation
            
        case .screen:
            return CIBlendKernel.screen
            
        case .softLight:
            return CIBlendKernel.softLight
            
        case .sourceAtop:
            return CIBlendKernel.sourceAtop
        }
    }
}

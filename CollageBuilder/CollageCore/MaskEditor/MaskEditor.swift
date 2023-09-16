//
//  MaskEditor.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 10.09.2023.
//

import SwiftUI

struct MaskEditor {
    
    var context: CIContext
    var settings: EraserSettings

    private(set) var maskImage: UIImage
    private var originalMaskImage: UIImage
    private var points = [CGPoint]()
    
    init(context: CIContext, settings: EraserSettings, maskImage: UIImage) {
        self.context = context
        self.settings = settings
        self.maskImage = maskImage
        self.originalMaskImage = maskImage
    }
    
    mutating func draw(to point: CGPoint) {
        addPoint(point)
        drawPoints()
    }
    
    mutating func end(in point: CGPoint) {
        addPoint(point)
        drawPoints()
        originalMaskImage = maskImage
        points = []
    }
    
    private func drawLines() -> UIImage {
        let format = UIGraphicsImageRendererFormat()
        format.scale = 1
        
        let linesImage = UIGraphicsImageRenderer(
            size: maskImage.size,
            format: format
        ).image {
            let context = $0.cgContext

            for point in points {
                if point == points.first {
                    context.move(to: point)
                } else {
                    context.addLine(to: point)
                }
            }
            
            context.setLineWidth(settings.size)
            context.setStrokeColor(UIColor.white.cgColor)
            context.setLineCap(.round)
            context.setLineJoin(.round)
            context.strokePath()
        }
        
        return linesImage
        
    }
    
    private mutating func addPoint(_ point: CGPoint) {
        let correctPoint = CGPoint(
            x: maskImage.size.width * point.x,
            y: maskImage.size.height * point.y
        )
        
        points.append(correctPoint)
    }
    
    private mutating func drawPoints() {
        guard let originalMaskImage = originalMaskImage.imageCI,
              let linesImage = drawLines().imageCI else {
            return
        }
        
        let mask = linesImage.blurred(with: settings.softness)
            .composited(over: originalMaskImage)
        
        maskImage = UIImage(ciImage: mask, context: context)
    }
    
    struct EraserSettings {
        var size: CGFloat
        var softness: CGFloat
    }
}

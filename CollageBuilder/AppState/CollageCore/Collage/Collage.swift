//
//  Collage.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 02.08.2023.
//

import Foundation

struct Collage: Codable {
    var shapes: [ShapeData]
    var dependencies: [DependentPoints]
    var cornerRadius: CGFloat
    var background: ShapeData
    var texts: [TextSettings]
    var stickers: [Sticker]
    let id: String
    
    var controlPoints: [ControlPoint] {
        shapes.flatMap { $0.controlPoints }
    }
    
    var maxZPosition: Int {
        (shapes.map(\.zPosition) +
         texts.map(\.zPosition)).max() ?? 1
    }
}

extension Collage {
    static var empty: Collage {
        .init(shapes: [],
              dependencies: [],
              cornerRadius: 0,
              background: .init(
                elements: [.rectangle(.init(
                    origin: .zero,
                    size: .init(side: 1)
                ))],
                zPosition: 0,
                blendMode: .normal,
                blur: .none,
                adjustments: .defaultAdjustments,
                transforms: .init()
              ),
              texts: [],
              stickers: [],
              id: "1")
    }
}

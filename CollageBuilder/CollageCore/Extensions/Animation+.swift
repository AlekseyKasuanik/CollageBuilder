//
//  Animation+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 17.09.2023.
//

import SwiftUI

extension Animation {
    
    func repeatWhile(_ expression: Bool, autoreverses: Bool = true) -> Animation {
        expression
        ? self.repeatForever(autoreverses: autoreverses)
        : self
    }
    
    static func curve(type: CurveType,  duration: Double = 0.35) -> Animation {
        timingCurve(type.curve.point1.x,
                    type.curve.point1.y,
                    type.curve.point2.x,
                    type.curve.point2.y,
                    duration: duration)
    }
}

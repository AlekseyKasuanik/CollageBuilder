//
//  ControlPoint.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct ControlPoint {
    var point: CGPoint
    let index: Int
    let type: PointType
    
    enum PointType: String {
        case point, curveEnd, curveControl, topMidX,
             bottomMidX, leftMidY, rightMidY
    }
}

extension ControlPoint: Identifiable {
    var id: String { index.description + type.rawValue }
}

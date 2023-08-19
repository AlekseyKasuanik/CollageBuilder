//
//  ControlPoint.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct ControlPoint {
    var point: CGPoint
    let indexInElement: Int
    let type: PointType
    let shapeID: String
    
    enum PointType: String {
        case point, curveEnd, curveControl, topMidX,
             bottomMidX, leftMidY, rightMidY
    }
}

extension ControlPoint: Identifiable {
    var id: String { indexInElement.description + shapeID + type.rawValue }
}

extension ControlPoint: Hashable {
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
}

//
//  CurveType.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 17.09.2023.
//

import Foundation

enum CurveType {
    case linear
    case ease
    case easeIn
    case easeOut
    case easeInOut
    
    //https://cubic-bezier.com/
    case custom(CGPoint, CGPoint)

    var curve: Curvee {
        switch self {
        case .linear:
            return .init(point1: .init(x: 0, y: 0),
                         point2: .init(x: 1, y: 1))

        case .ease:
            return .init(point1: .init(x: 0.25, y: 1),
                         point2: .init(x: 0.25, y: 1))

        case .easeIn:
            return .init(point1: .init(x: 0.42, y: 0),
                         point2: .init(x: 1, y: 1))

        case .easeOut:
            return .init(point1: .init(x: 0, y: 0),
                         point2: .init(x: 0.58, y: 1))

        case .easeInOut:
            return .init(point1: .init(x: 0.42, y: 0),
                         point2: .init(x: 0.58, y: 1))

        case .custom(let point1, let point2):
            return .init(point1: point1, point2: point2)
        }
    }

    struct Curvee {
        let point1: CGPoint
        let point2: CGPoint
    }
}

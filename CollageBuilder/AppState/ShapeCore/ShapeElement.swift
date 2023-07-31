//
//  ShapeElement.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum ShapeElement {
    case point(CGPoint)
    case curve(endPoint: CGPoint, control: CGPoint)
    case rectangle(CGRect)
    case ellipse(CGRect)
}

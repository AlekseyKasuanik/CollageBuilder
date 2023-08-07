//
//  CollageShape.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import SwiftUI

struct CollageShape: Shape {
    
    let shape: ShapeData
    let size: CGSize
    
    func path(in rect: CGRect) -> Path {
        PathCreator.create(size: size, shape: shape)
    }
    
}

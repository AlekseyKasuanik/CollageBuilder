//
//  CGRect+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.07.2023.
//

import Foundation

extension CGRect {
    
    init(size: CGSize, around: CGPoint) {
        self.init(origin: .init(x: around.x - size.width / 2,
                                y: around.y - size.width / 2),
                  size: size)
    }
}

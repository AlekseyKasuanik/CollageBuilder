//
//  CGRect+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.07.2023.
//

import Foundation

extension CGRect {
    
    init(size: CGSize, araund: CGPoint) {
        self.init(origin: .init(x: araund.x - size.width / 2,
                                y: araund.y - size.width / 2),
                  size: size)
    }
}

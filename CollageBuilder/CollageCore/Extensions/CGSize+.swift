//
//  CGSize+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.07.2023.
//

import Foundation

extension CGSize {
    
    init(side: CGFloat) {
        self.init(width: side, height: side)
    }
    
    static func *(lhs: CGSize, rhs: CGFloat) -> CGSize {
        CGSize(width: lhs.width * rhs,
               height: lhs.height * rhs)
    }
    
    func fill(_ size: CGSize) -> CGSize {
        let scale = max(size.width / width,
                        size.height / height)
        
        return self * scale
    }
}

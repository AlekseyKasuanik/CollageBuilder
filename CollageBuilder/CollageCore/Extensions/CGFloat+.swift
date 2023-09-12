//
//  CGFloat+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 24.08.2023.
//

import Foundation

extension CGFloat {
    func rounded(places: Int) -> CGFloat {
        let divisor = pow(10.0, CGFloat(places))
        return CGFloat((self * divisor).rounded()) / divisor
    }
}

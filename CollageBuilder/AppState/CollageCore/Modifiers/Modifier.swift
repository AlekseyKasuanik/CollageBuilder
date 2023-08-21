//
//  Modifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 09.08.2023.
//

import SwiftUI

protocol Modifier {
    func modify(_ image: CIImage) -> CIImage
    func modify(_ image: UIImage) -> UIImage
}

//
//  SharedContext.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 09.08.2023.
//

import CoreImage

enum SharedContext {
    static let context = CIContext(options: [
        .workingColorSpace: CGColorSpace(name: CGColorSpace.displayP3)!,
        .outputColorSpace: CGColorSpace(name: CGColorSpace.displayP3)!
    ])
}

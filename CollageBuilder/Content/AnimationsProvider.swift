//
//  AnimationsProvider.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.09.2023.
//

import Foundation

enum AnimationsProvider {
    static var allAnimations: [ContentAnimation] = [
        .init(name: "Opacity", settings: .init(opacity: .init(value: 0))),
        .init(name: "VShake", settings: .init(offset: .init(value: .init(x: 0, y: 0.2), duration: 0.2))),
        .init(name: "HShake", settings: .init(offset: .init(value: .init(x: 0.2, y: 0), duration: 0.2))),
        .init(name: "ZShake", settings: .init(rotation: .init(value: .pi / 8, duration: 0.2)))
    ]
}

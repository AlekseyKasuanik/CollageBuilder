//
//  ColorFilter.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage

protocol ColorFilter: Codable {
    var name: String { get }
    func apply(to image: CIImage) -> CIImage
}

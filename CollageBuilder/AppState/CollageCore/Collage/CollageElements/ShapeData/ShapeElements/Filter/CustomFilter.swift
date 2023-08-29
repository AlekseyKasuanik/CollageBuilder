//
//  CustomFilter.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage

struct CustomFilter: ColorFilter {
    let name: String
    let cubeData: Data
    
    func apply(to image: CIImage) -> CIImage {
        image
    }
}

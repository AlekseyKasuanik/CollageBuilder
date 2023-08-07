//
//  UIImage+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

extension UIImage: DataRepresentable {
    
    func getData() -> Data? {
        pngData()
    }
    
    static func create(from data: Data) -> UIImage? {
        UIImage(data: data)
    }
}

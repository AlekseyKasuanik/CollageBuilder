//
//  UIColor+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import SwiftUI

extension UIColor: DataRepresentable {
    
    func getData() -> Data? {
        try? JSONEncoder().encode(ColorData(self))
    }
    
    static func create(from data: Data) -> UIColor? {
        guard let colorData = try? JSONDecoder().decode(
            ColorData.self,
            from: data
        ) else {
            return nil
        }
        
        return colorData.color
    }

}

fileprivate struct ColorData: Codable {
    var r = CGFloat.zero
    var g = CGFloat.zero
    var b = CGFloat.zero
    var a = CGFloat.zero
    
    var color: UIColor {
        UIColor(red: r, green: g, blue: b, alpha: a)
    }
    
    init(_ color: UIColor) {
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
    }
}

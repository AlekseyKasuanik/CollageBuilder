//
//  Media.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

struct Media: Codable {
    
    @CodableWrapper var resource: Resource
    private(set) var id = UUID().uuidString
    
    enum Resource: DataRepresentable {
        case image(UIImage)
        
        func getData() -> Data? {
            switch self {
            case .image(let image):
                return image.getData()
            }
        }
        
        static func create(from data: Data) -> Resource? {
            if let image = UIImage.create(from: data) {
                return .image(image)
            } else {
                return nil
            }
        }
    }
    
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

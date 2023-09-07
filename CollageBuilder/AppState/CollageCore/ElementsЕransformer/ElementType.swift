//
//  ElementType.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import Foundation

enum ElementType {
    case shape(String)
    case text(String)
    
    var id: String {
        switch self {
        case .shape(let id), .text(let id):
            return id
        }
    }
    
    var shapeId: String? {
        guard case .shape(let id) = self else {
            return nil
        }
        
        return id
    }
    
    var textId: String? {
        guard case .text(let id) = self else {
            return nil
        }
        
        return id
    }
}

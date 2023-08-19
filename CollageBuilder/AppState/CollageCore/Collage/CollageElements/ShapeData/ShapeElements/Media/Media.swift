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
    
}

extension Media: Equatable {
    static func == (lhs: Media, rhs: Media) -> Bool {
        return lhs.id == rhs.id
    }
}

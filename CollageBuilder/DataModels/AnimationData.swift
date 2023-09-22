//
//  AnimationData.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 21.09.2023.
//

import Foundation

struct AnimationData: Identifiable {
    var name: String
    var settings: AnimationSettings
    
    var id: String { settings.id }
}

extension AnimationData: Hashable {
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
}

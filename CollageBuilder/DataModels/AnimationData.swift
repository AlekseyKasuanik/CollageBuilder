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

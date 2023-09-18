//
//  ContentAnimation.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.09.2023.
//

import Foundation

struct ContentAnimation: Identifiable {
    var name: String
    var settings: AnimationSettings
    
    var id: String { settings.id }
}

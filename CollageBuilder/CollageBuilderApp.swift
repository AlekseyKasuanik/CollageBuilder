//
//  CollageBuilderApp.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 30.07.2023.
//

import SwiftUI

@main
struct CollageBuilderApp: App {
    var body: some Scene {
        WindowGroup {
            CollageBuiderView(store: .preview)
        }
    }
    
    private func createStore() -> AppStore {
        .init(
            initial: .init(collage: .init(shapes: [],
                                          dependencies: [],
                                          cornerRadius: 0,
                                          id: UUID().uuidString,
                                          background: .color(.white))),
            reducer: .init()
        )
    }
}

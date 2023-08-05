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
            CollageBuiderView(store: createStore())
        }
    }
    
    private func createStore() -> AppStore {
        .init(
            initial: .init(collage: .init(shapes: [],
                                          dependencies: [],
                                          id: UUID().uuidString)),
            reducer: .init()
        )
    }
}

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
            CollageBuilderView(store: .preview)
        }
    }
    
    private func createStore() -> AppStore {
        let background = ShapeData(
            elements: [.rectangle(.init(
                origin: .zero,
                size: .init(side: 1)
            ))],
            zPosition: 0,
            blendMode: .normal,
            blur: .none,
            adjustments: .defaultAdjustments,
            transforms: .init()
        )
        
        let store = AppStore(
            initial: .init(collageSize: .init(side: 1000),
                           collage: .init(shapes: [],
                                          dependencies: [],
                                          cornerRadius: 0,
                                          background: background,
                                          texts: [],
                                          stickers: [],
                                          id: UUID().uuidString)),
            reducer: AppReducerBuilder.reducer
        )
        
        return store
    }
}

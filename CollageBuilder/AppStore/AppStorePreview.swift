//
//  AppStorePreview.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let element1 = ShapeElement.rectangle(.init(x: 0.05, y: 0.05, width: 0.4, height: 0.9))
        let element2 = ShapeElement.rectangle(.init(x: 0.55, y: 0.05, width: 0.4, height: 0.9))
        let collageID = UUID().uuidString
        
        let collage = Collage(
            shapes: [.init(elements: [element1]),
                     .init(elements: [element2])],
            dependencies: [],
            id: collageID
        
        )
        return AppStore(
            initial: AppState(collage: collage),
            reducer: AppReducer()
        )
    }
}

//
//  AppStorePreview.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let element1 = ShapeElement.rectangle(.init(x: 0.05, y: 0.05, width: 0.4, height: 0.4))
        let element2 = ShapeElement.rectangle(.init(x: 0.55, y: 0.05, width: 0.4, height: 0.4))
        let collageID = UUID().uuidString
        
        let background = ShapeData(
            elements: [.rectangle(.init(
                origin: .zero,
                size: .init(side: 1)
            ))],
            zPosition: 0,
            blendMode: .normal
        )
        
        let collage = Collage(
            shapes: [.init(elements: [element1], zPosition: 1, blendMode: .normal),
                     .init(elements: [element2], zPosition: 2, blendMode: .normal)],
            dependencies: [],
            cornerRadius: 20,
            background: background,
            id: collageID
        )
        
        return AppStore(
            initial: AppState(collage: collage),
            reducer: AppReducer()
        )
    }
}

//
//  AppStorePreview.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let collageSize = CGSize(side: 1000)
        let element1 = ShapeElement.rectangle(.init(x: 0.05, y: 0.05, width: 0.4, height: 0.4))
        let element2 = ShapeElement.rectangle(.init(x: 0.55, y: 0.05, width: 0.4, height: 0.4))
        let collageID = UUID().uuidString
        let text = TextSettings(collageSize: collageSize,
                                zPosition: 10,
                                text: "Text example")
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
        
        let collage = Collage(
            shapes: [.init(elements: [element1],
                           zPosition: 1,
                           blendMode: .normal,
                           blur: .none,
                           adjustments: .defaultAdjustments,
                           transforms: .init()),
                     .init(elements: [element2],
                           zPosition: 2,
                           blendMode: .normal,
                           blur: .none,
                           adjustments: .defaultAdjustments,
                           transforms: .init())],
            dependencies: [],
            cornerRadius: 20,
            background: background,
            texts: [text],
            id: collageID
        )
        
        return AppStore(
            initial: AppState(collageSize: collageSize, collage: collage),
            reducer: AppReducer()
        )
    }
}

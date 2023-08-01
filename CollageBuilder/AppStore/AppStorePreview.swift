//
//  AppStorePreview.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let element = ShapeElement.rectangle(.init(x: 0.4, y: 0.2, width: 0.2, height: 0.3))
        return AppStore(
            initial: AppState(shape: .init(elements: [element])),
            reducer: AppReducer()
        )
    }
}

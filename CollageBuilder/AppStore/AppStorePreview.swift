//
//  AppStorePreview.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

extension AppStore {
    static var preview: AppStore {
        let element = ShapeElement.rectangle(.init(x: 400, y: 200, width: 200, height: 300))
        return AppStore(
            initial: AppState(shape: .init(elements: [element])),
            reducer: AppReducer()
        )
    }
}

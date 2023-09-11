//
//  AppReducerBuilder.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 11.09.2023.
//

import Foundation

enum AppReducerBuilder {
    
    static var reducer: AppReducer {
        let collageReducer = CollageReducer(shapeReducer: ShapeReducer(),
                                            textReducer: TextReducer(),
                                            stickerReducer: StickerReducer())
        
        let shapesTranslator = ShapesTranslator(pointTouchSide: 0.1, translationStep: 0.01)
        let gestureReducer = GestureReducer(shapesTranslator: shapesTranslator,
                                            elementsTransformer: ElementsTransformer())
        
        return AppReducer(collageReducer: collageReducer,
                          gestureReducer: gestureReducer)
    }
}

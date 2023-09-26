//
//  AppReducerBuilder.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 11.09.2023.
//

import Foundation

enum AppReducerBuilder {
    
    static var reducer: AppReducer {
        
        let videoSettingsReducer = VideoSettingsReducer()
        let maskReducer = MaskSettingsReducer()
        let mediaReducer = MediaReducer(videoSettingsReducer: videoSettingsReducer,
                                        maskSettingsReducer: maskReducer)
        let shapeReducer = ShapeReducer(mediaReducer: mediaReducer)
        let textReducer = TextReducer()
        let stickerReducer = StickerReducer()
        let elementsTransformer = ElementsTransformer()
        
        let collageReducer = CollageReducer(shapeReducer: shapeReducer,
                                            textReducer: textReducer,
                                            stickerReducer: stickerReducer)
        
        let shapesTranslator = ShapesTranslator(pointTouchSide: 0.1, translationStep: 0.01)
        let gestureReducer = GestureReducer(shapesTranslator: shapesTranslator,
                                            elementsTransformer: elementsTransformer)
        
        return AppReducer(collageReducer: collageReducer,
                          gestureReducer: gestureReducer)
    }
}

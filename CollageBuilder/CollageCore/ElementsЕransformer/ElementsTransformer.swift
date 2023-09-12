//
//  ElementsTransformer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 04.09.2023.
//

import Foundation

struct ElementsTransformer: ElementsTransformerProtocol {
    
    private var element: ElementType?
    
    mutating func translate(_ gestureState: GestureType.GestureState<CGPoint>,
                            in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedElement(position, in: collage)
            return collage
            
        case .changed(let translation):
            return transformElement(.init(position: translation), in: collage)
        }
        
    }
    
    mutating func scale(_ gestureState: GestureType.GestureState<CGFloat>,
                        in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedElement(position, in: collage)
            return collage
            
        case .changed(let scale):
            return transformElement(.init(scale: scale), in: collage)
        }
    }
    
    mutating func rotate(_ gestureState: GestureType.GestureState<CGFloat>,
                         in collage: Collage) -> Collage {
        
        switch gestureState {
        case .began(let position):
            detectChangedElement(position, in: collage)
            return collage
            
        case .changed(let rotation):
            return transformElement(.init(rotation: rotation), in: collage)
        }
    }
    
    private func transformElement(_ transforms: Transforms,
                                  in collage: Collage) -> Collage {
        
        guard let element else {
            return collage
        }
        
        switch element {
        case .text(let id):
            return transformsText(transforms,
                                  in: collage,
                                  witch: id)
            
        case .shape(let id):
            return transformsShape(transforms,
                                  in: collage,
                                  witch: id)
            
        case .sticker(let id):
            return transformsSticker(transforms,
                                  in: collage,
                                  witch: id)
        }
        
    }
    
    private func transformsSticker(_ transforms: Transforms,
                                in collage: Collage,
                                witch id: String) -> Collage {
        
        guard let index = collage.stickers.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        let newTransforms = change(newCollage.stickers[index].transforms,
                                   with: transforms)
        newCollage.stickers[index].transforms = newTransforms
        
        return newCollage
    }
    
    private func transformsShape(_ transforms: Transforms,
                                in collage: Collage,
                                witch id: String) -> Collage {
        
        guard let index = collage.shapes.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        let newTransforms = change(newCollage.shapes[index].transforms,
                                   with: transforms)
        newCollage.shapes[index].transforms = newTransforms
        
        return newCollage
    }
    
    private func transformsText(_ transforms: Transforms,
                                in collage: Collage,
                                witch id: String) -> Collage {
        
        guard let index = collage.texts.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        let newTransforms = change(collage.texts[index].transforms,
                                   with: transforms)
        newCollage.texts[index].transforms = newTransforms
        
        return newCollage
    }
    
    private mutating func detectChangedElement(_ position: CGPoint,
                                             in collage: Collage) {
        
        element = PointsRecognizer.findElement(position, in: collage)
    }
    
    private func change(_ transforms: Transforms,
                        with newTransforms: Transforms) -> Transforms {
        
        var resultTransforms = transforms
        
        resultTransforms.position = transforms.position + newTransforms.position
        resultTransforms.rotation += newTransforms.rotation
        resultTransforms.scale *= newTransforms.scale
        
        return resultTransforms
    }
}

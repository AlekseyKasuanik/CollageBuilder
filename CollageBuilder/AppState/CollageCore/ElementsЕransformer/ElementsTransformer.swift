//
//  ElementsTransformer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 04.09.2023.
//

import Foundation

struct ElementsTransformer {
    
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
        
        var newCollage = collage
        
        
        switch element {
        case .text(let id):
            if let index = collage.texts.firstIndex(where: {
                $0.id == id
            }) {
                let newTransforms = change(newCollage.texts[index].transforms,
                                           with: transforms)
                newCollage.texts[index].transforms = newTransforms
            }
            
        case .shape(let id):
            if let index = collage.shapes.firstIndex(where: {
                $0.id == id
            }) {
                let newTransforms = change(newCollage.shapes[index].transforms,
                                           with: transforms)
                newCollage.shapes[index].transforms = newTransforms
            }
        }
        
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

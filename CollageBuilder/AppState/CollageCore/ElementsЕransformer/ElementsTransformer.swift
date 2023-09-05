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
        
        let shape = PointsRecognizer.findShape(position, in: collage)
        let text = PointsRecognizer.findText(position, in: collage)
        
        guard shape != nil || text != nil else {
            element = nil
            return
        }
        
        let element = [(ElementType.shape(shape?.id ?? ""), shape?.zPosition ?? .min),
                    (ElementType.text(text?.id ?? ""), text?.zPosition ?? .min)]
            .sorted(by: { $0.1 > $1.1})
            .first?.0
        
        self.element = element
    }
    
    private func change(_ transforms: Transforms,
                        with newTransforms: Transforms) -> Transforms {
        
        var resultTransforms = transforms
        
        resultTransforms.position = transforms.position + newTransforms.position
        resultTransforms.rotation += newTransforms.rotation
        resultTransforms.scale *= newTransforms.scale
        
        return resultTransforms
    }
    
   private enum ElementType {
        case shape(String)
        case text(String)
        
        var id: String {
            switch self {
            case .shape(let id), .text(let id):
                return id
            }
        }
    }
}

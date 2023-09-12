//
//  CollageReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 15.08.2023.
//

import Foundation

protocol CollageReducerProtocol {
    mutating func reduce(_ currentState: Collage,
                         _ action: CollageModification) -> Collage
}

struct CollageReducer: CollageReducerProtocol {
    
    private(set) var shapeReducer: ShapeReducerProtocol
    private(set) var textReducer: TextReducerProtocol
    private(set) var stickerReducer: StickerReducer
    
    mutating func reduce(_ currentState: Collage,
                         _ action: CollageModification) -> Collage {
        
        var newCollage = currentState
        
        switch action {
        case .addShape(let shapeData):
            newCollage.shapes.append(shapeData)
            
        case .changeBackground(let action):
            newCollage.background = shapeReducer.reduce(newCollage.background, action)
            
        case .connectControlPoints(let ids):
            newCollage = connectControlPoints(ids, in: newCollage)
            
        case .disconnectControlPoints(let ids):
            newCollage = disconnectControlPoints(ids, in: newCollage)
            
        case .changeCornerRadius(let radius):
            newCollage.cornerRadius = radius
            
        case .changeShape(let action, id: let id):
            newCollage = changeShape(action, id: id, in: newCollage)
            
        case .addText(let text):
            newCollage.texts.append(text)
            
        case .changeText(let action, id: let id):
            newCollage = changeText(action, id: id, in: newCollage)
            
        case .addSticker(let sticker):
            newCollage.stickers.append(sticker)
            
        case .changeSticker(let action, id: let id):
            newCollage = changeSticker(action, id: id, in: newCollage)
            
        case .removeShape(let id):
            newCollage.shapes.removeAll(where: { $0.id == id })
            
        case .removeText(let id):
            newCollage.texts.removeAll(where: { $0.id == id })
            
        case .removeSticker(let id):
            newCollage.stickers.removeAll(where: { $0.id == id })
        }
        
        return newCollage
        
    }
    
    private mutating func changeShape(_ action: ShapeModification,
                                      id: String,
                                      in collage: Collage) -> Collage {
        
        guard let shapeIndex = collage.shapes.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.shapes[shapeIndex] = shapeReducer.reduce(
            newCollage.shapes[shapeIndex],
            action
        )
        
        return newCollage
    }
    
    private mutating func changeText(_ action: TextModification,
                                     id: String,
                                     in collage: Collage) -> Collage {
        
        guard let textIndex = collage.texts.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.texts[textIndex] = textReducer.reduce(
            newCollage.texts[textIndex],
            action
        )
        
        return newCollage
    }
    
    private mutating func changeSticker(_ action: StickerModification,
                                        id: String,
                                        in collage: Collage) -> Collage {
        
        guard let stickerIndex = collage.stickers.firstIndex(where: {
            $0.id == id
        }) else {
            return collage
        }
        
        var newCollage = collage
        
        newCollage.stickers[stickerIndex] = stickerReducer.reduce(
            newCollage.stickers[stickerIndex],
            action
        )
        
        return newCollage
    }
    
    private func connectControlPoints(_ ids: Set<String>,
                                      in collage: Collage) -> Collage {
        
        var newCollage = collage
        guard let index = newCollage.dependencies.firstIndex(where: {
            !$0.pointIDs.intersection(ids).isEmpty
        }) else {
            newCollage.dependencies.append(.init(pointIDs: ids))
            return newCollage
        }
        
        newCollage.dependencies[index] = .init(pointIDs: ids)
        
        return newCollage
    }
    
    private func disconnectControlPoints(_ ids: Set<String>,
                                         in collage: Collage) -> Collage {
        
        guard let index = collage.dependencies.firstIndex(where: {
            $0.pointIDs.isSubset(of: ids)
        }) else {
            return collage
        }
        
        var newCollage = collage
        newCollage.dependencies.remove(at: index)
        
        return newCollage
    }
    
}

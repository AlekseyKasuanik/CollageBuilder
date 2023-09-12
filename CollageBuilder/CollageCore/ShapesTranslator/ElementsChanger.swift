//
//  ElementsChanger.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

enum ElementsChanger {
    
    static func change(_ point: ControlPoint,
                       in elements: [ShapeElement]) -> [ShapeElement] {
        
        switch point.type {
        case .point:
            return changePoint(point, in: elements)
            
        case .curveEnd:
            return changeCurveEnd(point, in: elements)
            
        case .curveControl:
            return changeCurveControl(point, in: elements)
            
        case .topMidX:
            return changeTopMidX(point, in: elements)
            
        case .bottomMidX:
            return changeBottomMidX(point, in: elements)
            
        case .leftMidY:
            return changeLeftMidY(point, in: elements)
            
        case .rightMidY:
            return changeRightMidY(point, in: elements)
        }
    }
    
    private static func changePoint(_ point: ControlPoint,
                                    in elements: [ShapeElement]) -> [ShapeElement] {
        var newElements = elements
        newElements[point.indexInElement] = .point(point.point)
        return newElements
    }
    
    private static func changeCurveEnd(_ point: ControlPoint,
                                       in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard case .curve(_, let oldControl) = elements[point.indexInElement] else {
            return elements
        }
        
        var newElements = elements
        newElements[point.indexInElement] = .curve(endPoint: point.point,
                                          control: oldControl)
        
        return newElements
    }
    
    private static func changeCurveControl(_ point: ControlPoint,
                                           in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard case .curve(let oldCurveEnd, _) = elements[point.indexInElement] else {
            return elements
        }
        
        var newElements = elements
        newElements[point.indexInElement] = .curve(endPoint: oldCurveEnd,
                                          control: point.point)
        
        return newElements
    }
    
    private static func changeTopMidX(_ point: ControlPoint,
                                      in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard let rect = getElementRect(for: elements[point.indexInElement]) else {
            return elements
        }
        
        let dHeight = point.point.y - rect.minY
        let newRect = CGRect(x: rect.minX,
                             y: point.point.y,
                             width: rect.width,
                             height: rect.height - dHeight)
        
        return change(newRect, in: elements, at: point.indexInElement)
    }
    
    private static func changeBottomMidX(_ point: ControlPoint,
                                         in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard let rect = getElementRect(for: elements[point.indexInElement]) else {
            return elements
        }

        let dHeight = point.point.y - rect.maxY
        let newRect = CGRect(x: rect.minX,
                             y: rect.minY,
                             width: rect.width,
                             height: rect.height + dHeight)

        return change(newRect, in: elements, at: point.indexInElement)
    }
    
    private static func changeLeftMidY(_ point: ControlPoint,
                                       in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard let rect = getElementRect(for: elements[point.indexInElement]) else {
            return elements
        }

        let dWidth = point.point.x - rect.minX
        let newRect = CGRect(x: point.point.x,
                             y: rect.minY,
                             width: rect.width - dWidth,
                             height: rect.height)

        return change(newRect, in: elements, at: point.indexInElement)
    }
    
    private static func changeRightMidY(_ point: ControlPoint,
                                        in elements: [ShapeElement]) -> [ShapeElement] {
        
        guard let rect = getElementRect(for: elements[point.indexInElement]) else {
            return elements
        }
        
        let dWidth = point.point.x - rect.maxX
        let newRect = CGRect(x: rect.minX,
                             y: rect.minY,
                             width: rect.width + dWidth,
                             height: rect.height)
        
        return change(newRect, in: elements, at: point.indexInElement)
    }
    
    private static func change(_ rect: CGRect,
                               in element: ShapeElement) -> ShapeElement {
        
        guard case .rectangle = element else {
            return .ellipse(rect)
        }
        
        return .rectangle(rect)
        
    }
    
    private static func change(_ rect: CGRect,
                        in elements: [ShapeElement],
                        at index: Int) -> [ShapeElement] {
        
        let newElement = change(rect, in: elements[index])
        var newElements = elements
        newElements[index] = newElement
        
        return newElements
        
    }
    
    private static func getElementRect(for element: ShapeElement) -> CGRect? {
        switch element {
        case .rectangle(let rect):
            return rect
            
        case .ellipse(let rect):
            return rect
            
        default:
            return nil
        }
    }
    
}

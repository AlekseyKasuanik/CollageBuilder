//
//  TextReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import Foundation

struct TextReducer: ReducerProtocol {
    
    
    mutating func reduce(_ currentState: TextSettings,
                         _ action: TextModification) -> TextSettings {
        
        var newText = currentState
        
        switch action {
        case .size(let size):
            newText.fontSize = size
            
        case .fontName(let name):
            newText.fontName = name
            
        case .kern(let kern):
            newText.kern = kern
            
        case .lineSpacing(let spacing):
            newText.lineSpacing = spacing
            
        case .alignment(let alignment):
            newText.alignment = alignment
            
        case .text(let text):
            newText.text = text
            
        case .textColor(let color):
            newText.textColor = color
            
        case .backgroundColor(let color):
            newText.backgroundColor = color
            
        case .cornerRadius(let radius):
            newText.cornerRadius = radius
            
        case .blendMode(let mode):
            newText.blendMode = mode
        }
        
        return newText
        
    }
    
}


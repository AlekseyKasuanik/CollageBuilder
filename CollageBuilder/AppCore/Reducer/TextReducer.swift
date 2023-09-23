//
//  TextReducer.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.09.2023.
//

import Foundation

protocol TextReducerProtocol {
    mutating func reduce(_ currentState: TextSettings,
                         _ action: TextModification) -> TextSettings
}

struct TextReducer: TextReducerProtocol {
    
    mutating func reduce(_ currentState: TextSettings,
                         _ action: TextModification) -> TextSettings {
        
        var newText = currentState
        
        switch action {
        case .changeSize(let size):
            newText.fontSize = size
            
        case .changeFontName(let name):
            newText.fontName = name
            
        case .changeKern(let kern):
            newText.kern = kern
            
        case .changeLineSpacing(let spacing):
            newText.lineSpacing = spacing
            
        case .changeAlignment(let alignment):
            newText.alignment = alignment
            
        case .changeText(let text):
            newText.text = text
            
        case .changeTextColor(let color):
            newText.textColor = color
            
        case .changeBackgroundColor(let color):
            newText.backgroundColor = color
            
        case .changeCornerRadius(let radius):
            newText.cornerRadius = radius
            
        case .changeBlendMode(let mode):
            newText.blendMode = mode
            
        case .changeZPosition(let index):
            newText.zPosition = index
            
        case .changeAnimation(let animation):
            newText.animation = animation
        }
        
        return newText
        
    }
    
}


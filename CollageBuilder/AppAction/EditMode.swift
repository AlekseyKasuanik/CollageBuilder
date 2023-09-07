//
//  EditMode.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 27.08.2023.
//

import Foundation

enum EditMode: String {
    case preview, edit
    
    mutating func next() {
        switch self {
        case .preview:
            self = .edit
        case .edit:
            self = .preview
        }
    }
}

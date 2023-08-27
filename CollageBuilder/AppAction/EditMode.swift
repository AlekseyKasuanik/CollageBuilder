//
//  EditMode.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 27.08.2023.
//

import Foundation

enum EditMode: String {
    case priview, edit
    
    mutating func next() {
        switch self {
        case .priview:
            self = .edit
        case .edit:
            self = .priview
        }
    }
}

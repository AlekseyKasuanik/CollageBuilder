//
//  ReducerProtocol.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

protocol ReducerProtocol {
    associatedtype State
    associatedtype Action
    
    func reduce(_ currentState: State, _ action: Action) -> State
}

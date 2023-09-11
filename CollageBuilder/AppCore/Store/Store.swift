//
//  Store.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

final class AppStore: ObservableObject {
    
    @Published private(set) var state: AppState
    
    private var reducer: AppReducerProtocol
    
    init(initial: AppState,
         reducer: AppReducerProtocol) {
        
        self.state = initial
        self.reducer = reducer
    }
    
    func dispatch(_ action: AppAction) {
        state = reducer.reduce(state, action)
    }
    
}

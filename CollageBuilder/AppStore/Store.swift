//
//  Store.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

typealias AppStore = Store<AppReducer>

final class Store<Reducer: ReducerProtocol>: ObservableObject {
    
    @Published private(set) var state: Reducer.State
    
    private var reducer: Reducer
    
    init(initial: Reducer.State,
         reducer: Reducer) {
        
        self.state = initial
        self.reducer = reducer
    }
    
    func dispatch(_ action: Reducer.Action) {
        state = reducer.reduce(state, action)
    }
    
}

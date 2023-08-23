//
//  CashManager.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 23.08.2023.
//

import Foundation

struct CashManager<HashType: Equatable, ValueType> {
    private var hash: HashType?
    private var value: ValueType?
    
    func getValue(for hash: HashType?) -> ValueType? {
        self.hash == hash ? value : nil
    }
    
    mutating func update(_ value: ValueType?, for hash: HashType?) {
        self.value = value
        self.hash = hash
    }
    
    mutating func clear() {
        update(nil, for: nil)
    }
}

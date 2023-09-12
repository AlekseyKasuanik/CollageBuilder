//
//  Optional+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import Foundation

extension Optional: DataRepresentable where Wrapped: DataRepresentable {
    
    func getData() -> Data? {
        self?.getData()
    }
    
    static func create(from data: Data) -> Optional<Wrapped.SelfType>? {
        Wrapped.create(from: data)
    }
}

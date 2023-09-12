//
//  DataRepresentable.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import Foundation

protocol DataRepresentable {
    associatedtype SelfType
    
    func getData() -> Data?
    static func create(from data: Data) -> SelfType?
}

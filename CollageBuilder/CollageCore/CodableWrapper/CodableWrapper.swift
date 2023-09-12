//
//  CodableWrapper.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

@propertyWrapper
struct CodableWrapper<ItemType: DataRepresentable>: Codable where ItemType.SelfType == ItemType {
    
    var item: ItemType
    
    var wrappedValue: ItemType {
        get { item }
        set { item = newValue }
    }
    
    init(item: ItemType) {
        self.item = item
    }
    
    init(wrappedValue: ItemType) {
        self.init(item: wrappedValue)
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let data = try container.decode(Data.self, forKey: CodingKeys.item)
        
        guard let item = ItemType.create(from: data) else {
            throw CodableWraperError.unableToDecode
        }
        
        self.item = item
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        
        let data = item.getData()
        if let data = data {
            try container.encode(data, forKey: CodingKeys.item)
        } else {
            try container.encodeNil(forKey: CodingKeys.item)
        }
    }
    
    enum CodableWraperError: Error {
        case unableToDecode
    }
    
    private enum CodingKeys: String, CodingKey {
        case item
    }
}


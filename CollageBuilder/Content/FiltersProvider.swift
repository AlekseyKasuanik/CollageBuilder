//
//  FiltersProvider.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import Foundation

enum FiltersProvider {
    
    static var allFilters: [ColorFilter] = [
        BaseFilter(name: "Chrome", filter: .photoEffectChrome),
        BaseFilter(name: "Fade", filter: .photoEffectFade),
        BaseFilter(name: "Instant", filter: .photoEffectInstant),
        BaseFilter(name: "Noir", filter: .photoEffectNoir),
        BaseFilter(name: "Process", filter: .photoEffectProcess),
        BaseFilter(name: "Tonal", filter: .photoEffectTonal),
        BaseFilter(name: "Transfer", filter: .photoEffectTransfer)
    ]
}

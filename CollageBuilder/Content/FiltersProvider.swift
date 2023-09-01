//
//  FiltersProvider.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import SwiftUI

enum FiltersProvider {
    
    static var allFilters: [ColorFilter] = [
        ColorFilter(name: "Chrome", type: .photoEffectChrome),
        ColorFilter(name: "Fade", type: .photoEffectFade),
        ColorFilter(name: "Instant", type: .photoEffectInstant),
        ColorFilter(name: "Noir", type: .photoEffectNoir),
        ColorFilter(name: "Process", type: .photoEffectProcess),
        ColorFilter(name: "Tonal", type: .photoEffectTonal),
        ColorFilter(name: "Transfer", type: .photoEffectTransfer),
        ColorFilter(name: "cube1", cubeImage: image(with: "cube1")!),
        ColorFilter(name: "cube2", cubeImage: image(with: "cube2")!),
        ColorFilter(name: "cube3", cubeImage: image(with: "cube3")!)
    ].compactMap { $0 }
    
    private static func image(with name: String) -> UIImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "png"),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}

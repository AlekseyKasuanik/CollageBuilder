//
//  StickersProvider.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.09.2023.
//

import SwiftUI

enum StickersProvider {
    
    static var allStickers: [Sticker] = [
        Sticker(zPosition: 1, image: image(with: "bonsai")!),
        Sticker(zPosition: 1, image: image(with: "boom-box")!),
        Sticker(zPosition: 1, image: image(with: "bottle")!),
        Sticker(zPosition: 1, image: image(with: "broken-heart")!),
        Sticker(zPosition: 1, image: image(with: "coffee")!),
        Sticker(zPosition: 1, image: image(with: "french")!),
        Sticker(zPosition: 1, image: image(with: "hacker")!),
        Sticker(zPosition: 1, image: image(with: "in-love")!),
        Sticker(zPosition: 1, image: image(with: "koala")!),
        Sticker(zPosition: 1, image: image(with: "koala4")!),
        Sticker(zPosition: 1, image: image(with: "koala5")!),
        Sticker(zPosition: 1, image: image(with: "koala6")!),
        Sticker(zPosition: 1, image: image(with: "koala7")!),
        Sticker(zPosition: 1, image: image(with: "koala8")!),
        Sticker(zPosition: 1, image: image(with: "maloik")!),
        Sticker(zPosition: 1, image: image(with: "meditation")!),
        Sticker(zPosition: 1, image: image(with: "question")!),
        Sticker(zPosition: 1, image: image(with: "read")!),
        Sticker(zPosition: 1, image: image(with: "rock-n-roll")!),
        Sticker(zPosition: 1, image: image(with: "spa")!),
        Sticker(zPosition: 1, image: image(with: "summer")!),
        Sticker(zPosition: 1, image: image(with: "work-from-home")!)
    ]
    
    private static func image(with name: String) -> UIImage? {
        guard let url = Bundle.main.url(forResource: name, withExtension: "png"),
              let data = try? Data(contentsOf: url),
              let image = UIImage(data: data) else {
            return nil
        }
        
        return image
    }
}

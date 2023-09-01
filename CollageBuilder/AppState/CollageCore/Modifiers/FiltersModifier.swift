//
//  FiltersModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 29.08.2023.
//

import CoreImage

final class FiltersModifier: Modifier {
    
    var filter: ColorFilter? {
        didSet { ciCash.clear()}
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    
    init(filter: ColorFilter? = nil) {
        self.filter = filter
    }
    
    func modify(_ image: CIImage) -> CIImage {
        guard let filter else { return image }
        
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let filteredImage = filter.apply(to: image)
        ciCash.update(filteredImage, for: image.hash)
        
        return filteredImage
    }
    
}


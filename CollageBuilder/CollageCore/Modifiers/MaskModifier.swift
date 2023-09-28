//
//  MaskModifier.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 28.09.2023.
//

import CoreImage

final class MaskModifier: Modifier {
    
    var mask: MaskSettings? {
        didSet { ciCash.clear()}
    }
    
    private var ciCash = CashManager<Int, CIImage>()
    
    init(mask: MaskSettings? = nil) {
        self.mask = mask
    }
    
    func modify(_ image: CIImage) -> CIImage {
        guard let ciMask = mask?.mask.imageCI else {
            return image
        }
        
        if let cashImage = ciCash.getValue(for: image.hash) {
            return cashImage
        }
        
        let maskedImage = image.withAlphaMask(ciMask)
        
        ciCash.update(maskedImage, for: image.hash)
        
        return maskedImage
    }
    
}

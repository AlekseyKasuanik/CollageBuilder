//
//  AdjustmentsSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 23.08.2023.
//

import SwiftUI

struct AdjustmentsSelectorView: View {
    
    @Binding var adjustments: Adjustments
    
    var body: some View {
        VStack(spacing: 0) {
            CommonSliderView(value: $adjustments.contrast.current,
                             range: adjustments.contrast.min...adjustments.contrast.max,
                             title: "contrast",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.brightness.current,
                             range: adjustments.brightness.min...adjustments.brightness.max,
                             title: "brightness",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.saturation.current,
                             range: adjustments.saturation.min...adjustments.saturation.max,
                             title: "saturation",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.exposure.current,
                             range: adjustments.exposure.min...adjustments.exposure.max,
                             title: "exposure",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.gamma.current,
                             range: adjustments.gamma.min...adjustments.gamma.max,
                             title: "gamma",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.hue.current,
                             range: adjustments.hue.min...adjustments.hue.max,
                             title: "hue",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.temperature.current,
                             range: adjustments.temperature.min...adjustments.temperature.max,
                             title: "temperature",
                             roundedPlaces: 0)
            CommonSliderView(value: $adjustments.tint.current,
                             range: adjustments.tint.min...adjustments.tint.max,
                             title: "tint",
                             roundedPlaces: 1)
            CommonSliderView(value: $adjustments.vibrance.current,
                             range: adjustments.vibrance.min...adjustments.vibrance.max,
                             title: "vibrance",
                             roundedPlaces: 1)
        }
    }
    
}

struct AdjustmentsSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AdjustmentsSelectorView(adjustments: .constant(.defaultAdjustments))
    }
}

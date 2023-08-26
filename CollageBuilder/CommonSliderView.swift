//
//  CommonSliderView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 24.08.2023.
//

import SwiftUI

struct CommonSliderView: View {
    
    @Binding var value: CGFloat
    var range: ClosedRange<CGFloat>
    var title: String?
    var roundedPlaces: Int = 1
    
    var body: some View {
        VStack(spacing: 0) {
            if let title {
                Text(title)
            }
            HStack {
                Slider(value: $value, in: range)
                Text(roundedPlaces == 0
                     ? Int(round(value)).description
                     : value.rounded(places: roundedPlaces).description)
                    .frame(width: 50)
            }
        }
    }
}

struct CommonSliderView_Previews: PreviewProvider {
    static var previews: some View {
        CommonSliderView(value: .constant(1), range: 0...2)
    }
}

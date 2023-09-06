//
//  TextSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

struct TextSelectorView: View {
    
    @State private var settings: TextSettings = .init(
        collageSize: .init(side: 1000),
        text: "Test \n text",
        fontSize: 30,
        lineSpacing: 10,
        transforms: .init(),
        zPosition: 2
    )
    
    var body: some View {
        VStack {
            Spacer()
            TextView(settings: $settings)
                .frame(width: settings.size.width,
                       height: settings.size.height)
            Spacer()
        }
    }
}

struct TextSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        TextSelectorView()
    }
}


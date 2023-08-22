//
//  ZPositionSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 14.08.2023.
//

import SwiftUI

struct ZPositionSelectorView: View {
    
    @Binding var zPosition: Int
    
    var body: some View {
        HStack {
            Text("Z position: ")
            Picker("", selection: $zPosition) {
                ForEach(-20...20, id: \.self) {
                    Text($0.description)
                }
            }
        }
    }
}

struct ZPozitionSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZPositionSelectorView(zPosition: .constant(2))
    }
}

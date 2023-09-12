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
            Spacer()
            Button {
                zPosition -= 1
            } label: {
                Image(systemName: "arrow.backward")
            }
            Text(zPosition.description)
            Button {
                zPosition += 1
            } label: {
                Image(systemName: "arrow.right")
            }
        }
    }
}

struct ZPozitionSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        ZPositionSelectorView(zPosition: .constant(2))
    }
}

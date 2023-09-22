//
//  AnimationSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 22.09.2023.
//

import SwiftUI

struct AnimationSelectorView: View {
    
    @Binding var animation: AnimationData?
    
    @State private var allAnimations = [AnimationData?]()
    
    var body: some View {
        HStack {
            Text("Animation: ")
            Picker("", selection: $animation) {
                ForEach(allAnimations, id: \.self) {
                    Text($0?.name ?? "none")
                }
            }
        }
        .task {
            allAnimations = await AnimationsProvider.allAnimations
            allAnimations.append(nil)
        }
    }
}

struct AnimationSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        AnimationSelectorView(animation: .constant(nil))
    }
}

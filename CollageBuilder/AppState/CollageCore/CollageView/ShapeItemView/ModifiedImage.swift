//
//  ModifiedImage.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 22.08.2023.
//

import SwiftUI

struct ModifiedImage: View {
    
    var id: Int
    var modifiers: [Modifier]
    var initialImaga: UIImage
    
    @State private var resultImage: UIImage?
    @State private var task: Task<Void, Never>?
    
    var body: some View {
        ZStack {
            if let resultImage {
                Image(uiImage: resultImage)
                    .resizable()
            } else {
                Image(uiImage: initialImaga)
                    .resizable()
            }
        }
        .onChange(of: id) { _ in
            task?.cancel()
            task = Task.detached {
                guard !Task.isCancelled else { return }
                let image = initialImaga.withModifiers(modifiers)
                guard !Task.isCancelled else { return }
                await MainActor.run {
                    resultImage = image
                }
            }
        }
    }
    
}

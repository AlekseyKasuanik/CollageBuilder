//
//  ShapeItemView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import SwiftUI
import Combine

struct ShapeItemView: View {
    
    let cornerRadius: CGFloat
    let shape: ShapeData
    let size: CGSize
    
    var strokeColor: UIColor = .clear
    var strokeWidth: CGFloat = 7
    
    var emptyColor: UIColor = .systemGray3
    
    @State private var blurModifier = BlurModifier(blur: .none)
    
    @State private var adjustmentsModifier = AdjustmentsModifier(
        adjustments: .defaultAdjustments
    )
    @State private var transformsModifier = TransformsModifier(
        transforms: .defaultTransforms,
        fitSize: .zero,
        fullSize: .zero
    )
    
    @State private var changesHandler = PassthroughSubject<Void, Never>()
    @State private var modifiers = [Modifier]()
    
    var body: some View {
        let collageShape = CollageShape(shape: shape, size: size)
        ZStack {
            media
                .frame(width: itemSize.width,
                       height: itemSize.height)
                .cornerRadius(cornerRadius)
        }
        .clipShape(collageShape)
        .blendMode(shape.blendMode.blendMode)
        .overlay {
            ZStack {
                RoundedRectangle(cornerRadius: cornerRadius)
                    .stroke(Color(strokeColor), lineWidth: strokeWidth)
                collageShape
                    .stroke(Color(strokeColor), lineWidth: strokeWidth)
            }
            .mask {
                collageShape
                    .cornerRadius(cornerRadius)
            }
        }
        .onAppear { setupProperties() }
        .onChange(of: shape.blur) { _ in changesHandler.send() }
        .onChange(of: shape.adjustments) { _ in changesHandler.send() }
        .onChange(of: shape.mediaTransforms) { _ in setupModifiers() }
        .onChange(of: shape.fitRect) {
            transformsModifier.fitSize = .init(
                width: size.width * $0.width * screenScale,
                height: size.height * $0.height * screenScale
            )
            setupModifiers()
        }
        .onReceive(changesHandler.throttle(
            for: 0.1,
            scheduler: DispatchQueue.main,
            latest: true
        )) { setupModifiers() }
    }
    
    @ViewBuilder
    private var media: some View {
        if let media = shape.media {
            switch media.resource {
            case .image(let image):
                ModifiedImage(
                    modifiers: modifiers,
                    image: image,
                    size: itemSize,
                    context: SharedContext.context
                )
            case .video(let video):
                VideoPlayerView(videoURL: video.videoUrl,
                                modifiers: modifiers,
                                settings: .defaultSettings,
                                context: SharedContext.context)
            case .color(let color):
                Color(uiColor: color)
            }
        } else {
            Color(uiColor: emptyColor)
        }
    }
    
    private var itemSize: CGSize {
        CGSize(width: shape.fitRect.width * size.width,
               height: shape.fitRect.height * size.height)
           
    }
    
    private func setupProperties() {
        blurModifier.blur = shape.blur
        adjustmentsModifier.adjustments = shape.adjustments
        transformsModifier.transforms = shape.mediaTransforms
        
        transformsModifier.fullSize = size * screenScale
        transformsModifier.fitSize = .init(
            width: size.width * shape.fitRect.width * screenScale,
            height: size.height * shape.fitRect.height * screenScale
        )
        
        setupModifiers()
    }
    
    private func setupModifiers() {
        setupAdjustmentsModifier()
        setupBlurModifier()
        setupTransformsModifier()
        modifiers = [
            adjustmentsModifier,
            blurModifier,
            transformsModifier
        ]
    }
    
    private func setupBlurModifier() {
        if blurModifier.blur != shape.blur {
            blurModifier.blur = shape.blur
        }
    }
    
    private func setupTransformsModifier() {
        if transformsModifier.transforms != shape.mediaTransforms {
            transformsModifier.transforms = shape.mediaTransforms
        }
    }
    
    private func setupAdjustmentsModifier() {
        if adjustmentsModifier.adjustments != shape.adjustments {
            adjustmentsModifier.adjustments = shape.adjustments
        }
    }
    
}

struct ShapeItemView_Previews: PreviewProvider {
    static var previews: some View {
        let element = ShapeElement.rectangle(.init(
            x: 0.1,
            y: 0.1,
            width: 0.8,
            height: 0.8
        ))
        
        let image = UIImage(named: "exampleImage1")!
        ScrollView([.vertical, .horizontal]) {
            ShapeItemView(
                cornerRadius: 0,
                shape: .init(elements: [element],
                             media: .init(resource: .image(image)),
                             zPosition: 1,
                             blendMode: .normal,
                             blur: .none,
                             adjustments: .defaultAdjustments,
                             mediaTransforms: .defaultTransforms),
                size: .init(side: 500)
            )
            .background(.red)
        }
    }
}


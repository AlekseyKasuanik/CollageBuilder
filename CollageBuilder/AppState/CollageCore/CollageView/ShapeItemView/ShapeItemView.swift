//
//  ShapeItemView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import SwiftUI
import Combine
import AVFoundation

struct ShapeItemView: View {
    
    let cornerRadius: CGFloat
    let shape: ShapeData
    let size: CGSize
    
    var isPlaying: Bool
    var strokeColor: UIColor
    var strokeWidth: CGFloat
    
    var emptyColor: UIColor = .systemGray3
    
    @State private var blurModifier = BlurModifier(blur: .none)
    
    @State private var adjustmentsModifier = AdjustmentsModifier(
        adjustments: .defaultAdjustments
    )
    @State private var transformsModifier = TransformsModifier(
        transforms: .init(),
        fitSize: .zero,
        fullSize: .zero
    )
    @State private var filtersModifier = FiltersModifier()
    
    @State private var changesHandler = PassthroughSubject<Void, Never>()
    @State private var modifiers = [Modifier]()
    
    var body: some View {
        let collageShape = CollageShape(shape: shape, size: size)
        ZStack {
            MediaView(media: shape.media,
                      modifiers: modifiers,
                      size: itemSize,
                      emptyColor: emptyColor,
                      isPlaying: isPlaying)
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
        .zIndex(Double(shape.zPosition))
        .position(
            x: shape.fitRect.midX * size.width,
            y: shape.fitRect.midY * size.height
        )
        .onAppear { setupProperties() }
        .onChange(of: shape.blur) { _ in changesHandler.send() }
        .onChange(of: shape.adjustments) { _ in changesHandler.send() }
        .onChange(of: shape.transforms) { setupTransformsModifier($0) }
        .onChange(of: shape.filter) { setupFiltersModifier($0) }
        .onChange(of: shape.fitRect) {
            transformsModifier.fitSize = .init(
                width: size.width * $0.width * screenScale,
                height: size.height * $0.height * screenScale
            )
            changeModifiers()
        }
        .onReceive(changesHandler.throttle(
            for: 0.1,
            scheduler: DispatchQueue.main,
            latest: true
        )) { setupBlurAndAdjustments() }
    }
    
    private var itemSize: CGSize {
        CGSize(width: shape.fitRect.width * size.width,
               height: shape.fitRect.height * size.height)
           
    }
    
    private func setupProperties() {
        blurModifier.blur = shape.blur
        adjustmentsModifier.adjustments = shape.adjustments
        transformsModifier.transforms = shape.transforms
        
        transformsModifier.fullSize = size * screenScale
        transformsModifier.fitSize = .init(
            width: size.width * shape.fitRect.width * screenScale,
            height: size.height * shape.fitRect.height * screenScale
        )
        filtersModifier.filter = shape.filter
        
        changeModifiers()
    }
    
    private func setupBlurAndAdjustments() {
        if blurModifier.blur != shape.blur {
            blurModifier.blur = shape.blur
        }
        
        if adjustmentsModifier.adjustments != shape.adjustments {
            adjustmentsModifier.adjustments = shape.adjustments
        }
        
        changeModifiers()
    }
    
    private func changeModifiers() {
        modifiers = [
            adjustmentsModifier,
            blurModifier,
            filtersModifier,
            transformsModifier
        ]
    }
    
    private func setupTransformsModifier(_ transform: Transforms) {
        if transformsModifier.transforms != transform {
            transformsModifier.transforms = shape.transforms
        }
        
        changeModifiers()
    }
    
    private func setupFiltersModifier(_ filter: ColorFilter?) {
        if filtersModifier.filter != filter {
            filtersModifier.filter = filter
        }
        
        changeModifiers()
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
                             transforms: .init()),
                size: .init(side: 500),
                isPlaying: true,
                strokeColor: .green,
                strokeWidth: 7
            )
            .background(.red)
        }
    }
}


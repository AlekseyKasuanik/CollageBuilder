//
//  ShapeItemView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 08.08.2023.
//

import SwiftUI

struct ShapeItemView: View {
    
    let shape: ShapeData
    let size: CGSize
    
    var emptyColor: UIColor = .systemGray3
    
    var body: some View {
        ZStack {
            if let media = shape.media,
               case .image(let image) = media.resource {
                Image(uiImage: image)
                    .resizable()
                    .frame(
                        width: shape.fitRect.width * size.width,
                        height: shape.fitRect.height * size.height
                    )
                    .rotationEffect(.degrees(45))
                    .position(
                        x: shape.fitRect.midX * size.width,
                        y: shape.fitRect.midY * size.height
                    )
            } else {
                Color(uiColor: emptyColor)
            }
        }
        .frame(width: size.width,
               height: size.height)
        .clipShape(CollageShape(shape: shape, size: size))
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
                shape: .init(elements: [element],
                             media: .init(resource: .image(image))),
                size: .init(side: 500)
            )
            .background(.red)
        }
    }
}

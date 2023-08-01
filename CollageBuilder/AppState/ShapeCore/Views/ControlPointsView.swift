//
//  ControlPointsView.swift
//  LearningSwiftUI
//
//  Created by Алексей Касьяник on 25.07.2023.
//

import SwiftUI

struct ControlPointsView: View {
    
    let controlPoints: [ControlPoint]
    let size: CGSize
    
    var body: some View {
        ZStack {
            ForEach(controlPoints) { controlPoint in
                circle
                    .position(x: controlPoint.point.x * size.width,
                              y: controlPoint.point.y * size.height)
            }
        }
    }
    
    private var circle: some View {
        Circle()
            .fill(.blue)
            .frame(width: 25)
            .overlay {
                Circle()
                    .strokeBorder(Color(uiColor: .systemGray2), lineWidth: 3)
            }
    }
}

struct ControlPointsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPointsView(controlPoints: [
            .init(point: .init(x: 0.1, y: 0.1), index: 0, type: .point),
            .init(point: .init(x: 0.2, y: 0.2), index: 1, type: .point)
        ], size: .init(side: 1000))
    }
}

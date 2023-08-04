//
//  ControlPointsView.swift
//  LearningSwiftUI
//
//  Created by Алексей Касьяник on 25.07.2023.
//

import SwiftUI

struct ControlPointsView: View {
    
    @EnvironmentObject private var model: AppStore
    
    @Binding var selectedPointsIDs: Set<String>
    
    let controlPoints: [ControlPoint]
    let size: CGSize
    
    var body: some View {
        ZStack {
            ForEach(controlPoints) { controlPoint in
                createPoint(id: controlPoint.id)
                    .position(x: controlPoint.point.x * size.width,
                              y: controlPoint.point.y * size.height)
            }
        }
    }
    
    
    private func createPoint(id: String) -> some View {
        Circle()
            .fill(selectedPointsIDs.contains(id) ? .red : .blue)
            .frame(width: 25)
            .overlay {
                Circle()
                    .strokeBorder(Color(uiColor: .systemGray2), lineWidth: 3)
            }
    }
        
}

struct ControlPointsView_Previews: PreviewProvider {
    static var previews: some View {
        ControlPointsView(
            selectedPointsIDs: .constant(["2"]),
            controlPoints: [
                .init(point: .init(x: 0.1, y: 0.1), indexInElement: 0, type: .point, shapeID: "1"),
                .init(point: .init(x: 0.2, y: 0.2), indexInElement: 1, type: .point, shapeID: "2")
            ],
            size: .init(side: 1000)
        )
        .environmentObject(AppStore.preview)
    }
}

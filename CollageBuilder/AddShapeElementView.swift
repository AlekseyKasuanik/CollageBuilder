//
//  AddShapeElementView.swift
//  LearningSwiftUI
//
//  Created by Алексей Касьяник on 23.07.2023.
//

import SwiftUI

struct AddShapeElementView: View {
    
    let size: CGSize
    
    @EnvironmentObject private var store: AppStore
    
    @State private var xPoint = ""
    @State private var yPoint = ""
    
    @State private var xControlPoint = ""
    @State private var yControlPoint = ""
    
    @State private var width = ""
    @State private var height = ""
    
    @State private var mutatedShapeID = UUID().uuidString
    
    var body: some View {
        ScrollView {
            VStack {
                addShape
                addPointButton
                addCurveButton
                addRectangleButton
                addElipseButton
            }
        }
        .padding()
        .background(Color(uiColor: .systemGray6))
    }
    
    private var addPointButton: some View {
        VStack {
            Divider()
            Button {
                guard let x = Double(xPoint),
                      let y = Double(yPoint) else {
                    return
                }
                
                store.dispatch(.addElement(
                    .point(.init(x: x / size.width,
                                 y: y / size.height)),
                    shapeId: mutatedShapeID
                ))
            } label: {
                Text("Add Point")
            }
            HStack {
                Group {
                    TextField(text: $xPoint) {
                        Text("X")
                    }
                    TextField(text: $yPoint) {
                        Text("Y")
                    }
                }
                .padding()
                .frame(maxWidth: .infinity)
            }
            Divider()
        }
    }
    
    private var addShape: some View {
        VStack {
            Button {
                mutatedShapeID = UUID().uuidString
                store.dispatch(.addShape(.init(elements: [],
                                         id: mutatedShapeID)))
            } label: {
                Text("Add new shape")
            }
        }
    }
    
    private var addCurveButton: some View {
        VStack {
            Button {
                guard let endX = Double(xPoint),
                      let endY = Double(yPoint),
                      let controlX = Double(xControlPoint),
                      let controlY = Double(yControlPoint)
                else {
                    return
                }
                
                store.dispatch(.addElement(
                    .curve(endPoint: .init(x: endX / size.width,
                                           y: endY / size.height),
                           control: .init(x: controlX / size.width,
                                          y: controlY / size.height)),
                    shapeId: mutatedShapeID
                ))
            } label: {
                Text("Add Curve")
            }
            HStack {
                TextField(text: $xPoint) {
                    Text("endX")
                }
                TextField(text: $yPoint) {
                    Text("endY")
                }
            }
            HStack {
                TextField(text: $xControlPoint) {
                    Text("controlX")
                }
                TextField(text: $yControlPoint) {
                    Text("controlY")
                }
            }
            Divider()
        }
    }
    
    private var addRectangleButton: some View {
        VStack {
            Button {
                guard let x = Double(xPoint),
                      let y = Double(yPoint),
                      let width = Double(width),
                      let height = Double(height)
                else {
                    return
                }
                
                store.dispatch(.addElement(
                    .rectangle(.init(x: x / size.width,
                                     y: y / size.height,
                                     width: width / size.width,
                                     height: height / size.height)),
                    shapeId: mutatedShapeID
                ))
            } label: {
                Text("Add Rectangle")
            }
            HStack {
                TextField(text: $xPoint) {
                    Text("X")
                }
                TextField(text: $yPoint) {
                    Text("Y")
                }
            }
            HStack {
                TextField(text: $width) {
                    Text("Width")
                }
                TextField(text: $height) {
                    Text("Height")
                }
            }
            Divider()
        }
    }
    
    private var addElipseButton: some View {
        VStack {
            Button {
                guard let x = Double(xPoint),
                      let y = Double(yPoint),
                      let width = Double(width),
                      let height = Double(height)
                else {
                    return
                }
                
                store.dispatch(.addElement(
                    .ellipse(.init(x: x / size.width,
                                   y: y / size.height,
                                   width: width / size.width,
                                   height: height / size.height)),
                    shapeId: mutatedShapeID
                ))
            } label: {
                Text("Add Elipse")
            }
            HStack {
                TextField(text: $xPoint) {
                    Text("X")
                }
                TextField(text: $yPoint) {
                    Text("Y")
                }
            }
            HStack {
                TextField(text: $width) {
                    Text("Width")
                }
                TextField(text: $height) {
                    Text("Height")
                }
            }
            Divider()
        }
    }
    
}

struct AddShapeElementView_Previews: PreviewProvider {
    static var previews: some View {
        AddShapeElementView(size: .init(side: 1000))
            .environmentObject(AppStore.preview)
    }
}

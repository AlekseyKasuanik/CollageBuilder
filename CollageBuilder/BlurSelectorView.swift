//
//  BlurSelectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 20.08.2023.
//

import SwiftUI

struct BlurSelectorView: View {
    
    @Binding var blur: Blur
    
    @State private var blurType = BlurType.none
    
    @State private var boxRadius: CGFloat = 20
    @State private var discRadius: CGFloat = 20
    @State private var gaussianRadius: CGFloat = 20
    @State private var motionRadius: CGFloat = 20
    @State private var motionAngle: CGFloat = 0
    
    var body: some View {
        VStack {
            Picker("", selection: $blurType) {
                ForEach(BlurType.allCases, id: \.self) {
                    Text($0.rawValue)
                }
            }
            .pickerStyle(.segmented)
            slidersView
        }
        .onChange(of: blurType) { _ in handleChnages() }
        .onChange(of: boxRadius) { _ in handleChnages() }
        .onChange(of: discRadius) { _ in handleChnages() }
        .onChange(of: gaussianRadius) { _ in handleChnages() }
        .onChange(of: motionRadius) { _ in handleChnages() }
        .onChange(of: motionAngle) { _ in handleChnages() }
        .onAppear{ setupProperties() }
    }
    
    @ViewBuilder
    private var slidersView: some View {
        switch blurType {
        case .box:
            createSlider(for: $boxRadius, range: 0...100)
            
        case .disc:
            createSlider(for: $discRadius, range: 0...100)
            
        case .gaus:
            createSlider(for: $gaussianRadius, range: 0...100)
            
        case .motion:
            createSlider(for: $motionRadius, range: 0...100)
            createSlider(for: $motionAngle, range: 0...180)
            
        case .none:
            EmptyView()
        }
    }
    
    private func createSlider(for value: Binding<CGFloat>,
                              range: ClosedRange<CGFloat>) -> some View {
    
        HStack {
            Slider(value: value, in: range)
            Text(Int(value.wrappedValue).description)
                .frame(width: 40)
        }
    }
    
    private func handleChnages() {
        switch blurType {
            
        case .box:
            blur = .box(boxRadius
            )
        case .disc:
            blur = .disc(discRadius)
            
        case .gaus:
            blur = .gaussian(gaussianRadius)
            
        case .motion:
            blur = .motion(motionRadius,
                           angle: motionAngle / 180 * .pi)
            
        case .none:
            blur = .none
        }
    }
    
    private func setupProperties() {
        switch blur {
        case .box(let radius):
            blurType = .box
            boxRadius = radius
            
        case .disc(let radius):
            blurType = .disc
            discRadius = radius
            
        case .gaussian(let radius):
            blurType = .gaus
            gaussianRadius = radius
            
        case .motion(let radius, let angle):
            blurType = .motion
            motionRadius = radius
            motionAngle = angle * 180 / .pi
            
        case .none:
            blurType = .none
        }
    }
    
    private enum BlurType: String, CaseIterable {
        case box, disc, gaus, motion, none
    }
}

struct BlurSelectorView_Previews: PreviewProvider {
    static var previews: some View {
        BlurSelectorView(blur: .constant(.gaussian(20)))
    }
}

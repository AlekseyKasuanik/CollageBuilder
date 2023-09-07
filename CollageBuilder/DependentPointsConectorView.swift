//
//  DependentPointsConectorView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 18.08.2023.
//

import SwiftUI

struct DependentPointsConectorView: View {
    
    @EnvironmentObject private var store: AppStore
    
    var body: some View {
        HStack {
            conectButton
            cancelButton
            disconectButton
        }
        .buttonStyle(.plain)
        .opacity(store.state.selectedPointsIDs.isEmpty ? 0 : 1)
        .animation(.default, value: store.state.selectedPointsIDs)
    }
    
    private var disconectButton: some View {
        Button {
            store.dispatch(.changeCollage(.disconnectControlPoints(pointsIds)))
            store.dispatch(.removeSelectedPoints)
        } label: {
            createButtonBody(with: "Disconect")
        }
    }
    
    private var conectButton: some View {
        Button {
            store.dispatch(.changeCollage(.connectControlPoints(pointsIds)))
            store.dispatch(.removeSelectedPoints)
        } label: {
            createButtonBody(with: "Conect")
        }
    }
    
    private var cancelButton: some View {
        Button {
            store.dispatch(.removeSelectedPoints)
        } label: {
            createButtonBody(with: "Cancel")
        }
    }
                           
    private var pointsIds: Set<String> {
        store.state.selectedPointsIDs
    }
    
    private func createButtonBody(with text: String) -> some View {
        Capsule()
            .fill(Color(uiColor: .systemGray3))
            .frame(width: 100, height: 40)
            .overlay {
                Text(text)
            }
    }
}

struct DependentPointsConectorView_Previews: PreviewProvider {
    static var previews: some View {
        DependentPointsConectorView()
            .environmentObject(AppStore.preview)
    }
}

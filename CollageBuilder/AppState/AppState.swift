//
//  AppState.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 31.07.2023.
//

import Foundation

struct AppState {
    let collageSize: CGSize
    var collage: Collage
    var selectedShapeID: String?
    var selectedPointsIDs = Set<String>()
    var collageSettings = CollageSettings()
    var editMode = EditMode.edit
    var isShowingGrid = true
    var isPlayingCollage = false
}

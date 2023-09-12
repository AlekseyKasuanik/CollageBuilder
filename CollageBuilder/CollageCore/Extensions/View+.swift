//
//  View+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 28.08.2023.
//

import SwiftUI

extension View {
    var screenScale: CGFloat {
        UIScreen.current?.scale ?? 3
    }
}

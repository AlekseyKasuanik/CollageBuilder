//
//  UIScreen+.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 13.08.2023.
//

import SwiftUI

extension UIScreen {
    static var current: UIScreen? {
        for scene in UIApplication.shared.connectedScenes {
            guard let windowScene = scene as? UIWindowScene else { continue }
            
            for window in windowScene.windows {
                if window.isKeyWindow { return window.screen }
            }
        }
        
        return nil
    }
}

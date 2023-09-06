//
//  TextUIView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 03.09.2023.
//

import SwiftUI

final class TextUIView: UITextView {
    
    @Binding var settings: TextSettings
    
    init(settings: Binding<TextSettings>) {
        self._settings = settings
        super.init(frame: .zero, textContainer: nil)
        self.delegate = self
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func changeSettings(_ settings: TextSettings) {
        attributedText = settings.attributedString
    }
    
    func showKeyboard() {
        becomeFirstResponder()
    }
    
    func hideKeyboard() {
        resignFirstResponder()
    }
}

extension TextUIView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        guard let text,
              text != settings.text else {
            return
        }
        
        settings.text = text
    }
}

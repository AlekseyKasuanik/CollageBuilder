//
//  DataImporterView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 06.08.2023.
//

import SwiftUI

struct DataImporterView: UIViewControllerRepresentable {
    
    @Binding var data: Data?
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController  {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.data], asCopy: true)
        picker.delegate = context.coordinator
        picker.allowsMultipleSelection = false
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(data: $data)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        
        @Binding var data: Data?
        
        init(data: Binding<Data?>) {
            self._data = data
        }
        
        func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
            guard let url = urls.first,
                  let data = try? Data(contentsOf: url) else {
                return
            }
            
            self.data = data
        }
    }
}

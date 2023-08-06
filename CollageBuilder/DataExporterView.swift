//
//  DataExporterView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 06.08.2023.
//

import SwiftUI

struct DataExporterView: UIViewControllerRepresentable {
    
    let data: Data
    let fileName: String
    
    var fileURL: URL {
        let fileManager = FileManager.default
        return fileManager.temporaryDirectory.appendingPathComponent(fileName + ".data")
    }
    
    func makeUIViewController(context: Context) -> UIDocumentPickerViewController  {
        try? data.write(to: fileURL)
        
        let vc = UIDocumentPickerViewController(forExporting: [fileURL])
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIDocumentPickerViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(fileURL: fileURL)
    }
    
    class Coordinator: NSObject, UIDocumentPickerDelegate, UINavigationControllerDelegate {
        let fileURL: URL
        
        init(fileURL: URL) {
            self.fileURL = fileURL
        }
        
        func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
            try? FileManager.default.removeItem(at: fileURL)
        }
    }
}

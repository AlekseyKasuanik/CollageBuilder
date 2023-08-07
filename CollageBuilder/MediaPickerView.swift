//
//  MediaPickerView.swift
//  CollageBuilder
//
//  Created by Алексей Касьяник on 07.08.2023.
//

import SwiftUI

struct MediaPickerView: UIViewControllerRepresentable {
    
    @Binding var media: Media?
    @Binding var show: Bool
    
    func makeUIViewController(context: Context) -> UIImagePickerController  {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.delegate = context.coordinator
        return vc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        return Coordinator(media: $media, show: $show)
    }
    
    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        
        @Binding var media: Media?
        @Binding var show: Bool
        
        init(media: Binding<Media?>, show: Binding<Bool>) {
            self._media = media
            self._show = show
        }
        
        func imagePickerController(_ picker: UIImagePickerController,
                                   didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            
            if let image = info[.originalImage] as? UIImage {
                media = .init(resource: .image(image))
            }
            
            show = false
        }
        
    }
}

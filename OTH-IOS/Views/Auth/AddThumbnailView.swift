//
//  AddThumbnailView.swift
//  OTH-IOS
//
//  Created by Alden  Sullivan on 11/22/23.
//

import SwiftUI
import UIKit

struct AddThumbnailView: View {
    @State private var isImagePickerPresented = false
    @State private var selectedImage: UIImage?
    @State private var readyToNavigate:Bool = true
    
    var body: some View {
        NavigationStack{
            VStack{
                VStack(spacing:4){
                    Text("Add a thumbnail")
                        .foregroundColor(Theme.primaryText)
                        .font(.title)
                        .bold()
                    Text("You can always change it later")
                        .foregroundColor(Theme.primaryText)
                        .font(.callout)
                    Spacer()
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 200, height: 200)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.blue, lineWidth: 4))
                    }
                    
                    Button("Select Photo") {
                        isImagePickerPresented = true
                    }
                    Spacer()
                }
                .sheet(isPresented: $isImagePickerPresented) {
                    ImagePicker(selectedImage: $selectedImage)
                }
            }
            
            .frame(width: .infinity, height: .infinity)
            .padding([.top],64)
            .padding([.horizontal],20)
            .background(Theme.surface1)
            .navigationDestination(isPresented: $readyToNavigate) {
                AddThumbnailView()
            }
            
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?
    @Environment(\.presentationMode) var presentationMode
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                parent.selectedImage = image
            }
            
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        return picker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
}

struct AddThumbnailView_Previews: PreviewProvider {
    static var previews: some View {
        AddThumbnailView()
    }
}

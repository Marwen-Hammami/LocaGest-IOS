//
//  addTool.swift
//  LocaGest
//
//  Created by Mac Mini 6 on 28/11/2023.
//

import SwiftUI

struct addTool: View {
    @State private var isShowingPhotoPicker = false
    
    
    @State private var isImagePickerPresented = false
    @State private var isShowingImagePicker = false
    @State private var selectedImageURL: URL?
    @State private var selectedImage: Image?
    @State private var selectedImageName: String?
    
    @State private var name: String = ""
    @State private var marque: String = ""
    @State private var type: String = ""
    @State private var prix: Int?
    @State private var image: String = ""
    @State private var stock: Int?
    
    @State private var isScrolling = false
    
    
    
    
    
    var body: some View {
        NavigationView {

            VStack {
              
                Text("Ajouter Outil")
                           .font(.title)
                           .fontWeight(.bold)
                           .padding(.top, 0)
                    
                VStack {
                    
                    VStack (alignment: .leading, spacing: 0){
                        
                        VStack {
                            VStack{
                                Text("Nom")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                TextField("Nom", text: $name)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            VStack{
                                Text("Marque")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                TextField("Marque", text: $marque)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            VStack{
                                Text("Type")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                TextField("Type", text: $type)
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            
                            .padding(.horizontal)
                            .padding(.top, 16)
                            
                            VStack {
                                Text("Prix")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                
                                TextField("Enter the price", value: $prix, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .padding(.horizontal)
                            .padding(.top, 16)
                            
                            VStack {
                                Text("Stock")
                                    .font(.headline)
                                    .padding(.bottom, 4)
                                
                                TextField("Enter the stock", value: $stock, formatter: NumberFormatter())
                                    .textFieldStyle(RoundedBorderTextFieldStyle())
                            }
                            .padding(.horizontal)
                            .padding(.top, 16)
                        }
                        
                        
                        VStack {
                            
                            VStack(alignment: .leading, spacing: 16) {
                                VStack(alignment: .leading, spacing: 1) {
                                    HStack {
                                        Spacer()
                                        
                                        Button(action: {
                                            isImagePickerPresented.toggle()
                                        }) {
                                            Image("wrench_7185363")
                                                .resizable()
                                                .scaledToFit()
                                                .frame(width: 60, height: 100)
                                        }
                                        .frame(width: 38, height: 38)
                                        .background(RoundedRectangle(cornerRadius: 12)
                                            .fill(Color.white))
                                        .sheet(isPresented: $isImagePickerPresented) {
                                            ImagePicker(selectedImage: $selectedImage, selectedImageName: $selectedImageName, selectedImageURL: Binding.constant(nil))
                                        }
                                        
                                        Text("Add Image")
                                            .fontWeight(.medium)
                                            .foregroundColor(Color.black)
                                            .minimumScaleFactor(0.5)
                                            .multilineTextAlignment(.leading)
                                            .frame(width: 72, height: 30)
                                    }
                                    .frame(width: 140, alignment: .leading)
                                    .padding(.bottom, 28)
                                }
                            }
                            .padding()
                        }
                        
                        
                    }
                    
                    Button(action: {
                        
                    }) {
                        HStack {
                            Text("Add Tool")
                                .fontWeight(.medium)
                                .padding(.leading, 9)
                                .padding(.vertical, 6)
                                .foregroundColor(Color.white)
                                .minimumScaleFactor(0.5)
                                .multilineTextAlignment(.leading)
                                .background(RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.green))
                                .padding(.horizontal, 28)
                        }
                    }
                    .background(RoundedRectangle(cornerRadius: 4)
                        .fill(Color.green))
                    .padding(.horizontal, 28)
                    
                }
                .padding(.horizontal, 16)
                .animation(.easeInOut)
                .onAppear {
                    isScrolling = false
                }
                .onDisappear {
                    isScrolling = true
                }
            }
        }
    }
    

    
    struct ImagePicker: UIViewControllerRepresentable {
        @Binding var selectedImage: Image?
        @Binding var selectedImageName: String?
        @Binding var selectedImageURL: URL?  // Add this line
        @Environment(\.presentationMode) var presentationMode
        
        func makeUIViewController(context: Context) -> UIImagePickerController {
            let picker = UIImagePickerController()
            picker.delegate = context.coordinator
            return picker
        }
        
        func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}
        
        func makeCoordinator() -> Coordinator {
            Coordinator(self)
        }
        
        class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
            var parent: ImagePicker
            
            init(_ parent: ImagePicker) {
                self.parent = parent
            }
            func saveImageToDocumentsDirectory(image: UIImage, imageName: String) -> String? {
                guard let documentsDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
                    return nil
                }
                
                let fileURL = documentsDirectory.appendingPathComponent(imageName)
                if let imageData = image.jpegData(compressionQuality: 1.0) {
                    do {
                        try imageData.write(to: fileURL)
                        return fileURL.path
                    } catch {
                        print("Error saving image data: \(error)")
                        return nil
                    }
                }
                return nil
            }
            
            func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                if let uiImage = info[.originalImage] as? UIImage {
                    parent.selectedImage = Image(uiImage: uiImage)
                    parent.selectedImageURL = URL(fileURLWithPath: saveImageToDocumentsDirectory(image: uiImage, imageName: "dynamic_image.jpg") ?? "")
                    
                    // Get the image URL
                    if let imageUrl = info[.imageURL] as? URL {
                        parent.selectedImageName = imageUrl.deletingPathExtension().lastPathComponent
                    }
                }
                parent.presentationMode.wrappedValue.dismiss()
            }
        }
    }
}

struct AddToolsView_Previews: PreviewProvider {
    static var previews: some View {
        addTool()
    }
}

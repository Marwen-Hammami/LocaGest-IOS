//
//  SelectedImageViewModel.swift
//  LocaGest
//
//  Created by Karim Hammami on 29/11/2023.
//

import SwiftUI
import PhotosUI

class SelectedImageViewModel: ObservableObject {
    @Published var selectedItem: PhotosPickerItem? {
        didSet{ Task {try await loadImage()} }
    }
    
    @Published var selectedImage: Image?
    
    func loadImage() async throws {
        guard let item = selectedItem else {return}
        guard let imageData = try await item.loadTransferable(type: Data.self) else {return}
        guard let uiImage = UIImage(data: imageData) else {return}
        self.selectedImage = Image(uiImage: uiImage)
    }
}

import SwiftUI

struct Ajouter_Voiture: View {
    @ObservedObject var carViewModel: CarViewModel
    
    @State private var immatriculation = ""
    @State private var marque = ""
    @State private var modele = ""
    @State private var carburant = ""
    @State private var boite = ""
    @State private var type = ""
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented: Bool = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Image("Logo 1")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)

                Text("Ajouter Voiture")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)

                Button(action: {
                    self.showImagePicker()
                }) {
                    if let selectedImage = selectedImage {
                        Image(uiImage: selectedImage)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .padding(.top, 10)
                    } else {
                        Image(systemName: "camera")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("Accent"))
                            .padding(.top, 10)
                    }
                }

                VStack(spacing: 20) {
                    TextField("Immatriculation", text: $immatriculation)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)

                    TextField("Marque", text: $marque)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)

                    TextField("Modèle", text: $modele)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)

                    Picker("Carburant", selection: $carburant) {
                        Text("Essence").tag("Essence")
                        Text("Diesel").tag("Diesel")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)

                    Picker("Boite", selection: $boite) {
                        Text("Manuelle").tag("Manuelle")
                        Text("Automatique").tag("Automatique")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)

                    Picker("Type", selection: $type) {
                        Text("Sedan").tag("Sedan")
                        Text("SUV").tag("SUV")
                        Text("Hatchback").tag("Hatchback")
                        Text("Convertible").tag("Convertible")
                        Text("Truck").tag("Truck")
                        Text("Sportive").tag("Sportive")
                        Text("autre").tag("autre")
                    }
                    .pickerStyle(MenuPickerStyle())
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                }
                .padding(.top, 10)
                
                

                Button(action: {
                    let UIimage = self.selectedImage
                    let etatVoiture = self.carburant
                    let cylindree = self.boite
                    let createdCar = CarRequest(
                        immatriculation: immatriculation,
                        marque: marque,
                        modele: modele,
                        image: "1702314813552.jpg",
                        cylindree: cylindree,
                        etatVoiture: etatVoiture,
                        type: type,
                        prixParJour: 5
                    )
                    carViewModel.createCar(car: createdCar
                                         //  ,image : selectedImage
                    )
                }) {
                    
                    Text("Ajouter")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 30)
                

                Spacer()
            }
        }
        .sheet(isPresented: $isImagePickerPresented, content: {
            ImagePicker(selectedImage: self.$selectedImage)
        })
    }

    func showImagePicker() {
        self.isImagePickerPresented.toggle()
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var selectedImage: UIImage?

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        @Binding var selectedImage: UIImage?

        init(selectedImage: Binding<UIImage?>) {
            _selectedImage = selectedImage
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                selectedImage = uiImage
            }

            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(selectedImage: $selectedImage)
    }

    func makeUIViewController(context: UIViewControllerRepresentableContext<ImagePicker>) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: UIViewControllerRepresentableContext<ImagePicker>) {}
}

struct Ajouter_Voiture_Previews: PreviewProvider {
    static var previews: some View {
        Ajouter_Voiture(carViewModel: CarViewModel())
    }
}

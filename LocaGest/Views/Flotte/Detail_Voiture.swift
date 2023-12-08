import SwiftUI

struct Detail_Voiture: View {
    let car : Car
    @StateObject var carViewModel = CarViewModel()
    @State private var carDeleted = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)

            VStack {
                HStack {
                    Spacer()

                    Text("Détail voiture  ")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }

                HStack {
                    Text("Immatriculation : \(car.immatriculation)")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Marque :\(car.marque) ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Modèle :\(car.marque) ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

//                HStack {
//                    Text("Carburant :\(car.c) ")
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                        .padding(.leading, 20)
//                    
//                    Spacer()
//                }

//                HStack {
//                    Text("Boite : ")
//                        .padding()
//                        .background(Color.green)
//                        .cornerRadius(10)
//                        .padding(.horizontal)
//                        .padding(.leading, 20)
//                        .padding(.bottom, 60)
//                    
//                    Spacer()
//                }
                
                // Emplacement pour une image
                Image(systemName: "car.fill")
                    .resizable()
                    .frame(width: 50, height: 50)
                    .padding()
                    .background(Color.green)
                    .cornerRadius(10)

                Spacer()

                HStack {
                    Button("Modifier") {
                        // Action lorsque le bouton "Modifier" est appuyé
                    }
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                    
                    Spacer()
                    NavigationLink(
                        destination: DetailFlotte(carViewModel: carViewModel),
                        isActive: $carDeleted // Use a state variable to control the navigation
                    ) {
                        EmptyView() // An empty view as NavigationLink requires a visible view
                    }
                    
                    Button {
                        Task {
                            do {
                                try await carViewModel.deleteCar(immatriculation: car.immatriculation)
                                carDeleted = true
                                // Handle success, maybe refresh your list of cars
                            } catch {
                                // Handle the error, display an alert, etc.
                                print("Error deleting car: \(error)")
                            }
                        }
                    } label: {
                        Text("Supprimer")
                            .padding()
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                            .padding()
                    }
                }

                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        }.onAppear(){
            print(car)
        }
    }
}

struct Detail_Voiture_Previews: PreviewProvider {
    static var previews: some View {
        
        let sampleCar = Car(
                    id: "sampleID",
                    immatriculation: "ABC123",
                    marque: "Toyota",
                    modele: "Camry",
                    image: "sampleImageURL",
                    cylindree: "sampleCylindree",
                    etatVoiture: "sampleEtatVoiture",
                    type: "sampleType",
                    prixParJour: 50
                )

        Detail_Voiture(car: sampleCar)
    }
}

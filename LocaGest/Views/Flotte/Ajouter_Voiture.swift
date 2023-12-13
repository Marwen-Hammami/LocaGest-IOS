import SwiftUI

struct Ajouter_Voiture: View {
    @ObservedObject var carViewModel: CarViewModel
    
    @State private var immatriculation = ""
    @State private var marque = ""
    @State private var modele = ""
    @State private var carburant = ""
    @State private var boite = ""
    @State private var type = ""
   // @State private var newCar: CarRequest?
    
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
                        // Logique pour choisir une image depuis la bibliothèque ou l'appareil photo
                        // Vous devrez probablement utiliser UIImagePickerController ou une bibliothèque tierce.
                    }) {
                        Image(systemName: "camera") // Utilisez un autre système d'icône selon vos besoins
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .foregroundColor(Color("Accent"))
                    }
                    .padding(.top, 10)
                
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
                        let etatVoiture = self.carburant
                        let cylindree = self.boite
                        let createdCar = CarRequest(
                         
                            immatriculation: immatriculation,
                            marque: marque,
                            modele: modele,
                            image: "autre",
                            cylindree: cylindree,
                            etatVoiture: etatVoiture,
                            type: type,
                            prixParJour: 0
                        )
                        carViewModel.createCar(car: createdCar)
                      //  self.newCar = createdCar
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
                }}

                }
            }
        
    
    
    struct Ajouter_Voiture_Previews: PreviewProvider {
        static var previews: some View {
            Ajouter_Voiture(carViewModel: CarViewModel())
        }
    }


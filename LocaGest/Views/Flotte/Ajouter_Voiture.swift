import SwiftUI

struct Ajouter_Voiture: View {
    @State private var immatriculation = ""
    @State private var marque = ""
    @State private var modele = ""
    @State private var carburant = ""
    @State private var boite = ""
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                Spacer()
                Spacer()
                
                Image("LogoLogaGest")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)
                
                Spacer()
                
                Text("Ajouter Voiture")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
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
                    
                    TextField("Carburant", text: $carburant)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                    
                    TextField("Boite", text: $boite)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                }
                .padding(.top, 50)
                
                Button(action: {
                    // Ajoutez le code pour traiter l'ajout de la voiture ici
                    print("Voiture ajoutée avec succès!")
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
    }
}

struct Ajouter_Voiture_Previews: PreviewProvider {
    static var previews: some View {
        Ajouter_Voiture()
    }
}

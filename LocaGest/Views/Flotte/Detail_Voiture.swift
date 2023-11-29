import SwiftUI

struct Detail_Voiture: View {
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

                    Text("Détail voiture")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)

                    Spacer()
                }

                HStack {
                    Text("Immatriculation: ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Marque: ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Modèle: ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Carburant: ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                    
                    Spacer()
                }

                HStack {
                    Text("Boite: ")
                        .padding()
                        .background(Color.green)
                        .cornerRadius(10)
                        .padding(.horizontal)
                        .padding(.leading, 20)
                        .padding(.bottom, 60)
                    
                    Spacer()
                }
                
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

                    Button("Supprimer") {
                        // Action lorsque le bouton "Supprimer" est appuyé
                    }
                    .padding()
                    .background(Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(10)
                    .padding()
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 20)
            }
            .padding(.top, UIApplication.shared.windows.first?.safeAreaInsets.top)
        }
    }
}

struct Detail_Voiture_Previews: PreviewProvider {
    static var previews: some View {
        Detail_Voiture()
    }
}

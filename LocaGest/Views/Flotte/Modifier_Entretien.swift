//
//  Modifier_Entretien.swift
//  LocaGest
//
//  Created by Maamoun on 28/11/2023.
//

import SwiftUI

struct Modifier_Entretien: View {
    @State private var id = ""
    @State private var titre = ""
    @State private var description = ""
    @State private var cout = ""
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
                
                Text("Modifier Entretien")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack(spacing: 20) {
                    TextField("ID", text: $id)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.horizontal, .bottom], 30)
                    
                    TextField("Titre", text: $titre)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.horizontal, .bottom], 30)
                    
                    TextField("Description", text: $description)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.horizontal, .bottom], 30)
                    
                    TextField("Cout", text: $cout)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding([.horizontal, .bottom], 30)
                }
                .padding(.top, 50)
                
                Button(action: {
                    // Ajoutez le code pour traiter l'ajout de la voiture ici
                    print("Entretien modifié avec succès!")
                }) {
                    Text("Modifier Entretien")
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

struct Modifier_Entretien_Previews: PreviewProvider {
    static var previews: some View {
        Modifier_Entretien()
    }
}

//
//  AjouterVoiture.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 28/11/2023.
//

import SwiftUI

struct AjouterVoiture: View {
    @State private var immatriculation = ""
    @State private var marque = ""
    @State private var modele = ""
    @State private var carburant = ""
    @State private var boite = ""

    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)

                VStack {
                    Form {
                        Section(header: Text("Ajout voiture")) {
                            TextArea("Immatriculation", text: $immatriculation)
                                .frame(height: 50) // Ajustez la hauteur selon vos préférences
                            TextArea("Marque", text: $marque)
                                .frame(height: 50)
                            TextArea("Modèle", text: $modele)
                                .frame(height: 50)
                            TextArea("Carburant", text: $carburant)
                                .frame(height: 50)
                            TextArea("Boîte", text: $boite)
                                .frame(height: 50)
                        }
                    }

                    Button(action: {
                        // Ajouter le code pour traiter l'ajout de la voiture ici
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
                    .padding()
                }
                .navigationBarTitle("Ajout voiture", displayMode: .inline)
            }
        }
    }
}

struct AjouterVoiture_Previews: PreviewProvider {
    static var previews: some View {
        AjouterVoiture()
    }
}

struct TextArea: View {
    var placeholder: String
    @Binding var text: String

    init(_ placeholder: String, text: Binding<String>) {
        self.placeholder = placeholder
        self._text = text
    }

    var body: some View {
        TextEditor(text: $text)
            .padding(8)
            .cornerRadius(8)
            .overlay(
                RoundedRectangle(cornerRadius: 8)
                    .stroke(Color.gray, lineWidth: 1)
            )
            .frame(height: 50) // Ajustez la hauteur selon vos préférences
            .padding(.vertical, 4)
            .padding(.horizontal, 8)
            .disableAutocorrection(true)
            .multilineTextAlignment(.leading)
            .lineLimit(5)
            .overlay(
                Text(placeholder)
                    .foregroundColor(text.isEmpty ? Color(.placeholderText) : .clear)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 12)
            )
    }
}

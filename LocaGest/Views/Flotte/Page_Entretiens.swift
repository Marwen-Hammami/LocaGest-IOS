//
//  Page_Entretiens.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 29/11/2023.
//

import SwiftUI

struct Page_Entretiens: View {
    let entretiens: [HistoriqueEntretiens]

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
                    List(entretiens) { entretien in
                        NavigationLink(destination: Detail_Entretien()) {
                            EntretienRow(entretien: entretien)
                        }
                    }
                    .listStyle(GroupedListStyle())

                    Spacer()

                    NavigationLink(destination: Ajouter_Entretien()) {
                        Text("Ajouter un entretien")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                }
            }
            .navigationTitle("Détails des entretiens")
        }
    }
}

struct EntretienRow: View {
    var entretien: HistoriqueEntretiens

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 8) {
                Text("Titre: \(entretien.titre)")
                    .font(.headline)
                Text("Description: \(entretien.description)")
                    .font(.subheadline)
                Text("Coût: \(entretien.cout)")
                    .font(.subheadline)
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
            )

            Spacer()

            Image(systemName: "wrench.and.screwdriver")
                .resizable()
                .frame(width: 50, height: 50)
                .padding()
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("Main"), Color.white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .cornerRadius(10)

            NavigationLink(destination: Detail_Entretien( )) {
                Text("Détail")
                    .foregroundColor(Color("Accent"))
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.clear)
    }
}




struct Page_Entretiens_Previews: PreviewProvider {
    static var previews: some View {
        let sampleEntretiens = [
            HistoriqueEntretiens(id: UUID(), titre: "Entretien 1", description: "Description 1", cout: 100),
            HistoriqueEntretiens(id: UUID(), titre: "Entretien 2", description: "Description 2", cout: 150)
            // Add more entretiens as needed
        ]

        return Page_Entretiens(entretiens: sampleEntretiens)
    }
}

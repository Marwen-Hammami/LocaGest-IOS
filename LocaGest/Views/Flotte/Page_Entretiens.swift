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
                        NavigationLink(destination: EntretienDetailView(entretien: entretien)) {
                            EntretienRow(entretien: entretien)
                        }
                    }
                    .listStyle(GroupedListStyle())

                    Spacer()

                    NavigationLink(destination: AjouterEntretienView()) {
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

            NavigationLink(destination: EntretienDetailView(entretien: entretien)) {
                Text("Détail")
                    .foregroundColor(Color("Accent"))
                    .font(.subheadline)
            }
        }
        .padding()
        .background(Color.clear)
    }
}

struct EntretienDetailView: View {
    var entretien: HistoriqueEntretiens

    var body: some View {
        VStack {
            Text("Titre: \(entretien.titre)")
                .font(.title)

            Spacer()

            Text("Description: \(entretien.description)")
                .font(.subheadline)
            Text("Coût: \(entretien.cout)")
                .font(.subheadline)

            Spacer()
        }
        .navigationBarTitle(Text("\(entretien.titre)"), displayMode: .inline)
    }
}

struct AjouterEntretienView: View {
    var body: some View {
        Text("Formulaire d'ajout d'entretien")
            .font(.title)
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

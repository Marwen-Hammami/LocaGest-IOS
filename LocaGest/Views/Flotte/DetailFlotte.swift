//
//  DetailFlotte.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 28/11/2023.
//

import SwiftUI

struct DetailFlotte: View {
    let cars: [Car]

    var body: some View {
        NavigationView {
            VStack {
                List(cars) { car in
                    NavigationLink(destination: CarDetailView(car: car)) {
                        CarRow(car: car)
                    }
                }
                .listStyle(GroupedListStyle())
                .background(
                    LinearGradient(
                        gradient: Gradient(colors: [Color("Main"), Color.white]),
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                    .edgesIgnoringSafeArea(.all)
                )

                Spacer()

                NavigationLink(destination: AjouterVoitureView()) {
                    Text("Ajouter une voiture")
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .foregroundColor(.white)
                        .cornerRadius(8)
                        .padding()
                }
            }
            .navigationTitle("Détails de la flotte")
        }
    }
}

struct CarRow: View {
    var car: Car

    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Marque: \(car.marque )")
                    .font(.headline)
                Text("Modèle: \(car.modele )")
                    .font(.subheadline)
                Text("Immatriculation: \(car.immatriculation ?? "")")
                    .font(.subheadline)
                Text("Disponibilité: \(car.disponibility.rawValue)")
                    .font(.subheadline)
            }

            Spacer()

            NavigationLink(destination: CarDetailView(car: car)) {
                Text("Détail")
                    .foregroundColor(Color("Accent"))
            }
        }
        .padding()
    }
}

struct CarDetailView: View {
    var car: Car

    var body: some View {
        VStack {
            Text("\(car.marque ) \(car.modele )")
                .font(.title)

            Spacer()

            Text("Immatriculation: \(car.immatriculation ?? "")")
                .font(.subheadline)
            Text("Carburant: \(car.carburant.rawValue)")
                .font(.subheadline)
            Text("Boîte de vitesses: \(car.boite.rawValue)")
                .font(.subheadline)
            Text("Disponibilité: \(car.disponibility.rawValue)")
                .font(.subheadline)

            Spacer()
        }
        .navigationBarTitle(Text("\(car.marque ) \(car.modele )"), displayMode: .inline)
    }
}

struct AjouterVoitureView: View {
    var body: some View {
        Text("Formulaire d'ajout de voiture")
            .font(.title)
    }
}

struct DetailFlotte_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCars = [
            Car(id: UUID(), immatriculation: "ABC123", marque: "Toyota", modele: "Camry", carburant: .essence, boite: .automatique, disponibility: .disponible),
            Car(id: UUID(), immatriculation: "XYZ456", marque: "Honda", modele: "Accord", carburant: .diesel, boite: .manuelle, disponibility: .louee)
            // Ajoutez d'autres voitures selon vos besoins
        ]

        return DetailFlotte(cars: sampleCars)
    }
}

import SwiftUI

struct DetailFlotte: View {
    @ObservedObject var carViewModel: CarViewModel

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
                    Text("LocaGest")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .padding(.top, 20)

                    if carViewModel.isLoading {
                        ProgressView("Chargement...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .scaleEffect(2)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    } else {
                        ScrollView {
                            LazyVStack(spacing: 16) {
                                ForEach(carViewModel.cars) { car in
                                    CarCardView(car: car, carViewModel: carViewModel)
                                }
                            }
                            .padding()
                        }
                    }

                    Spacer()

                    NavigationLink(destination: Ajouter_Voiture()) {
                        Text("Ajouter")
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.green)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                            .padding()
                    }
                    .padding(.bottom, 20)
                }
            }
            .navigationTitle("LocaGest")
            .accentColor(.green)
            .onAppear {
                carViewModel.fetchCars()
            }
        }
    }
}

struct CarCardView: View {
    var car: Car
    @ObservedObject var carViewModel: CarViewModel

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text("Marque: \(car.marque)")
                .font(.headline)
            Text("Modèle: \(car.modele)")
                .font(.subheadline)
            Text("Immatriculation: \(car.immatriculation ?? "")")
                .fontWeight(.bold)
                .font(.subheadline)
            Text("Disponibilité: \(car.disponibility.rawValue)")
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
        .cornerRadius(10)
        .foregroundColor(.black)

        HStack {
            Spacer()
             
                Text("Détails")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
            }
        }
    }


struct DetailFlotte_Previews: PreviewProvider {
    static var previews: some View {
        let carViewModel = CarViewModel()

        return DetailFlotte(carViewModel: carViewModel)
    }
}

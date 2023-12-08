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
                            VStack(spacing: 16) {
                                ForEach(carViewModel.cars) { car in
                                    CarCardView(car: car, carViewModel: carViewModel)
                                }
                            }
                            .padding()
                        }
                    }

                    Spacer()

                    NavigationLink(destination: Ajouter_Voiture(carViewModel: carViewModel)) {
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
            }.task {
                do {
                    await carViewModel.fetchCars()
                }catch{
                    print("sdfsdfdsfsdf")
                }
                
            }
            .navigationTitle("LocaGest")
            .accentColor(.green)
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

            // Conditionally render immatriculation if it is not nil
            
            Text("Immatriculation: \(car.immatriculation)")
                    .fontWeight(.bold)
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

            NavigationLink(destination: Detail_Voiture(car: car)) {
                Text("Détails")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .padding(.bottom, 10)
            }
        }
    }
}

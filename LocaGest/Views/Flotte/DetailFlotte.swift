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
        NavigationLink(destination: Detail_Voiture(car: car)) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Marque: \(car.marque)")
                        .font(.headline)
                        .foregroundColor(.white)
                    Text("Modèle: \(car.modele)")
                        .font(.subheadline)
                        .foregroundColor(.white)

                    // Conditionally render immatriculation if it is not nil
                    Text("Immatriculation: \(car.immatriculation ?? "")")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(
               /* ("Dacia_Logan")
                    .resizable()
                    .scaledToFill()*/
                
         
                
                AsyncImage(url: URL(string: "https://locagest.onrender.com/images/car/\(car.image)")) { phase in
                                     switch phase {
                                     case .empty:
                                         ProgressView()
                                     case .success(let image):
                                         image
                                             .resizable()
                                             .scaledToFill()
                                     case .failure:
                                         Image(systemName: "photo")
                                             .resizable()
                                             .scaledToFill()
                                     @unknown default:
                                         EmptyView()
                                     }
                                 }
                
                
            )
            .cornerRadius(20)
            .frame(width: 340, height: 180) // Ajustez ces valeurs selon vos besoins
        }
        .buttonStyle(PlainButtonStyle())
    }
}

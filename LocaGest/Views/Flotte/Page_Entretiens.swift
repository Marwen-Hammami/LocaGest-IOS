import SwiftUI

struct Page_Entretiens: View {
    @ObservedObject var entretienViewModel: EntretienViewModel

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
                    if entretienViewModel.isLoading {
                        ProgressView("Chargement...")
                            .progressViewStyle(CircularProgressViewStyle(tint: .green))
                            .scaleEffect(2)
                            .foregroundColor(.white)
                            .padding(.top, 20)
                    } else {
                        ScrollView {
                            VStack(spacing: 16) {
                                ForEach(entretienViewModel.historiqueEntretiens) { historiqueEntretien in
                                    EntretienCardView(historiqueEntretiens: historiqueEntretien, entretienViewModel: entretienViewModel)
                                }
                            }
                            .padding()
                        }
                    }

                    Spacer()

                    NavigationLink(destination: Ajouter_Entretien()) {
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
            .task {
                do {
                    await entretienViewModel.fetchEntretiens()
                } catch {
                    print("Failed to fetch entretiens: \(error.localizedDescription)")
                }
            }
            .navigationTitle("LocaGest")
            .accentColor(.green)
        }
    }
}

struct EntretienCardView: View {
    var historiqueEntretiens: HistoriqueEntretiens
//    historiqueEntretiens.description = ""
    @ObservedObject var entretienViewModel: EntretienViewModel

    var body: some View {
        NavigationLink(destination: Detail_Entretien()) {
            ZStack {
                Rectangle()
                    .foregroundColor(Color.black.opacity(0.3))
                    .cornerRadius(20)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                
                VStack(alignment: .leading, spacing: 8) {
                    Text("Immatriculation: \(historiqueEntretiens.immatriculation ?? "")")
                        .fontWeight(.bold)
                        .font(.subheadline)
                        .foregroundColor(.white)
                    
                    Text("Titre: \(historiqueEntretiens.titre ?? "") ")
                        .font(.subheadline)
                        .foregroundColor(.white)
                }
                .padding()
            }
            .background(
                AsyncImage(url: URL(string: "https://locagest.onrender.com/images/historique_entretien/\(historiqueEntretiens.image)")) { phase in
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
            .frame(width: 340, height: 180)
        }
        .buttonStyle(PlainButtonStyle())
    }
}

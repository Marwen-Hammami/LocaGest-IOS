import SwiftUI

struct ReservationListView: View {
    @StateObject private var viewModel = ReservationViewModel()
    @State private var isShowingAddPage = false
    @State private var showDeleteConfirmation = false
    @State private var selectedStatus: String? = nil
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.reservations?.filter { reservation in
                        selectedStatus == nil || reservation.Statut == selectedStatus
                    } ?? []) { reservation in
                        ReservationCardView(reservation: reservation)
                            .contextMenu {
                                Button(action: {
                                    if let index = viewModel.reservations?.firstIndex(where: { $0.id == reservation.id }) {
                                        // viewModel.deleteReservation(at: index)
                                    }
                                }) {
                                    Label("Delete", systemImage: "trash")
                                }
                            }
                    }
                }
                .onAppear {
                    viewModel.fetchReservations()
                }
                
                Spacer()
                
                bottomNavigationBar()
                //  }
                    .navigationBarTitle("Reservations")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .navigationBarLeading) {
                            addButton()
                        }
                    }
                    .sheet(isPresented: $isShowingAddPage) {
                        AddReservation(viewModel: ReservationViewModel())
                    }
            }
        }
    }
    func addButton() -> some View {
        Button(action: {
            isShowingAddPage = true
        }) {
            Image(systemName: "plus")
                .font(.title2)
                .foregroundColor(.white)
                .padding(8)
                .background(Color.primary)
                .clipShape(Circle())
        }
    }
    
    func bottomNavigationBar() -> some View {
        HStack {
            Spacer()
            
            Button(action: {
                selectedStatus = nil // Afficher toutes les réservations
            }) {
                Text("All")
                    .font(.title2)
                    .foregroundColor(selectedStatus == nil ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = "Achevée" // Afficher les réservations achevées
            }) {
                Text("Completed")
                    .font(.title2)
                    .foregroundColor(selectedStatus == "Achevée" ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = "Payée" // Afficher les réservations payées
            }) {
                Text("Paid")
                    .font(.title2)
                    .foregroundColor(selectedStatus == "Payée" ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
            
            Button(action: {
                selectedStatus = "Réservée" // Afficher les réservations réservées
            }) {
                Text("Reserved")
                    .font(.title2)
                    .foregroundColor(selectedStatus == "Réservée" ? .blue : .gray)
                    .padding(8)
            }
            
            Spacer()
        }
        .padding(.bottom, 8)
        .background(Color.white)
    }
}

struct ReservationListView_Previews: PreviewProvider {
    static var previews: some View {
        ReservationListView()
    }
}

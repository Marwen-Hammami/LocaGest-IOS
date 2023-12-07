import SwiftUI

struct ReservationDetailView: View {
    @StateObject private var reservationModel = ReservationModel()
    @StateObject private var viewModel = ReservationViewModel()
    let reservation: Reservation
    @State private var showDeleteConfirmation = false
    @State private var isShowingUpdatePage = false
    
    @State private var navigateToReservationList = false
    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                Image("car1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                VStack(alignment: .leading, spacing: 8) {
                    Text("STATUT: \(reservation.Statut)")
                        .font(.title)
                        .fontWeight(.medium)

                    Text("Total: \(reservation.Total)")
                        .font(.body)
                        .foregroundColor(.secondary)

                    VStack {
                        Image(systemName: "calendar")
                        Text("Start Date: \(reservation.DateDebut)")
                            .font(.body)
                            .fontWeight(.medium)

                        Image(systemName: "calendar")
                        Text("End Date: \(reservation.DateFin)")
                            .font(.body)
                            .fontWeight(.medium)

                        Image(systemName: "clock")
                        Text("Start Time: \(reservation.HeureDebut)")
                            .font(.body)
                            .fontWeight(.medium)

                        Image(systemName: "clock")
                        Text("End Time: \(reservation.HeureFin)")
                            .font(.body)
                            .fontWeight(.medium)
                    }

                    Button(action: {
                        isShowingUpdatePage = true
                    }) {
                        Text("Update")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.orange)
                            .cornerRadius(50)
                            .padding(.leading, 0)
                    }

                    Button(action: {
                        showDeleteConfirmation = true
                    }) {
                        Text("Delete")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(50)
                            .padding(.leading, 0)
                    }
                    .alert(isPresented: $showDeleteConfirmation) {
                        Alert(
                            title: Text("Confirmation"),
                            message: Text("Voulez-vous vraiment supprimer cette réservation ?"),
                            primaryButton: .destructive(Text("Supprimer")) {
                                viewModel.deleteReservation(reservationID: reservation.id) { error in
                                    if let error = error {
                                        print("Erreur lors de la suppression de la réservation : \(error)")
                                    } else {
                                        if let index = reservationModel.reservations.firstIndex(where: { $0.id == reservation.id }) {
                                            reservationModel.deleteReservation(at: index)
                                            
                                            // Activer la navigation après la suppression
                                            navigateToReservationList = true
                                        }
                                    }
                                }
                            },
                            secondaryButton: .cancel()
                        )
                    }
                }
                .padding(16)
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(8)
            .navigationBarTitle("Reservation Details", displayMode: .inline)
            .background(
                // Utilisez un NavigationLink pour effectuer la navigation programmatically
                NavigationLink(
                    destination: ReservationListView(),
                    isActive: $navigateToReservationList
                ) {
                    EmptyView()
                }
                .isDetailLink(false)
            )
        }
        .sheet(isPresented: $isShowingUpdatePage) {
            //UpdateReservation(reservation: reservation, viewModel: reservationModel)
        }
    }
}

struct ReservationDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let reservationModel = ReservationModel()

        if let reservation = reservationModel.reservations.first {
            return AnyView(ReservationDetailView(reservation: reservation))
        } else {
            return AnyView(Text("No reservation"))
        }
    }
}


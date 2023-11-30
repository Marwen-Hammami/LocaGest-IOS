import SwiftUI

struct ReservationDetailView: View {
    @StateObject private var reservationModel = ReservationModel()
    let reservation: Reservation
    @State private var showDeleteConfirmation = false
    
    @State private var isShowingUpdatePage = false

    
    var body: some View {
        NavigationView {
            VStack(alignment: .leading, spacing: 8) {
                
                // Image
                Image("car1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()

                // Details
                VStack(alignment: .leading, spacing: 8) {
                    // Reservation status
                    Text("STATUT: \(reservation.statut.rawValue)")
                        .font(.title)
                        .fontWeight(.medium)

                    // Reservation total
                    Text("Total: \(reservation.total)")
                        .font(.body)
                        .foregroundColor(.secondary)

                    // VStack for date and info icons
                    VStack {
                        // Calendar icon and reservation start date
                        Image(systemName: "calendar")
                        Text("Start Date: \(reservation.dateDebut)")
                            .font(.body)
                            .fontWeight(.medium)

                        // Calendar icon and reservation end date
                        Image(systemName: "calendar")
                        Text("End Date: \(reservation.dateFin)")
                            .font(.body)
                            .fontWeight(.medium)

                        // Calendar icon and reservation start time
                        Image(systemName: "clock")
                        Text("Start Time: \(reservation.heureDebut)")
                            .font(.body)
                            .fontWeight(.medium)

                        // Calendar icon and reservation end time
                        Image(systemName: "clock")
                        Text("End Time: \(reservation.heureFin)")
                            .font(.body)
                            .fontWeight(.medium)
                    }
                    
                    Button(action: {
                        //interface update
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

                    // Button with the "trash" icon for deletion
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
    //                            if let index = reservationModel.reservations.firstIndex(where: { $0.id == reservation.id }) {
    //                                reservationModel.deleteReservation(at: index)
    //                                showDeleteConfirmation = false
    //                            }
                            },
                            secondaryButton: .cancel()
                        )
                    }

                   /* Button(action: {
                        // Action when "Cancel" button is tapped
                    }) {
                        Text("Delete")
                            .font(.system(size: 20))
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height: 50)
                            .background(Color.red)
                            .cornerRadius(50)
                            .padding(.leading, 0)
                        
                        
                        
                        
                    }*/
                }
                .padding(16)
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(8)
            .navigationBarTitle("Reservation Details", displayMode: .inline)
        }
        .sheet(isPresented: $isShowingUpdatePage) {
            UpdateReservation(reservation: reservation, reservationModel: reservationModel) { newReservation in
                reservationModel.updateReservation(newReservation)
            }
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

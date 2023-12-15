import SwiftUI


struct ReservationDetailView: View {
    @StateObject private var reservationModel = ReservationModel()
        @StateObject private var viewModel = ReservationViewModel()
        @StateObject private var paymentHandler: PaymentHandler
    @State var reservation: Reservation
        @State private var showDeleteConfirmation = false
        @State private var isShowingUpdatePage = false
        @State private var paymentSuccess = false
        @State private var navigateToReservationList: Bool = false

        // Initialize paymentHandler in the initializer
        init(reservation: Reservation, paymentHandler: PaymentHandler) {
            self.reservation = reservation
            self._paymentHandler = StateObject(wrappedValue: paymentHandler)
           
        }



    
    
    
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

                    Text("Total: \(reservation.Total, specifier: "%.2f") EUR")
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

                    HStack {
                        Spacer()
                        
                        // Bouton de modification
                        if reservation.Statut != StatutRes.payee.rawValue {
                            Button(action: {
                                isShowingUpdatePage = true
                            }) {
                                Image(systemName: "square.and.pencil")
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.blue)
                                    .frame(width: 20, height: 20)
                            }
                            Spacer()
                        }
                        
                        // Bouton de paiement
                        if reservation.Statut != StatutRes.payee.rawValue {
                            Button(action: {
                                self.paymentHandler.startPayment(total: self.reservation.Total) { (success) in
                                    if success {
                                        self.paymentSuccess = true
                                        viewModel.markReservationAsPaid(reservationId: self.reservation.id)
                                    } else {
                                        print("Failed")
                                    }
                                }
                            }) {
                                HStack {
                                    Image(systemName: "creditcard")
                                        .resizable()
                                        .scaledToFit()
                                        .foregroundColor(.green)
                                        .frame(width: 20, height: 20)

                                    Text("Payer")
                                        .font(.body)
                                        .fontWeight(.medium)
                                }
                                .padding(8)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                            }
                            Spacer()
                        }
                        
                        // Bouton de suppression
                        Button(action: {
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash")
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red)
                                .frame(width: 20, height: 20)
                        }
                        Spacer()
                    }
                    .padding(.leading, 0)


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
            .background(
                Image("back1").resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.all))
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(8)
            .navigationBarTitle("Reservation Details", displayMode: .inline)
            .font(.largeTitle)
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
            UpdateReservation (reservation: reservation)
        }


    }
}

//struct ReservationDetailView_Previews: PreviewProvider {
//    static var previews: some View {
//        let paymentHandler = PaymentHandler()  // Initialize PaymentHandler here
//        PanierView(paymentHandler: paymentHandler)
//        let reservationModel = ReservationModel()
//
//        if let reservation = reservationModel.reservations.first {
//            return AnyView(ReservationDetailView(reservation: reservation))
//        } else {
//            return AnyView(Text("No reservation"))
//        }
//    }
//}


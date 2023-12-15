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

                    HStack {
                        Spacer()
                        
                        Button(action: {
                            isShowingUpdatePage = true
                        }) {
                            Image(systemName: "square.and.pencil") // Choisir le nom de l'icône que vous souhaitez
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.blue) // Changer la couleur selon vos besoins
                                .frame(width: 20, height: 20) // Ajuster la taille selon vos besoins
                        }

                        Spacer()
                        
                    
                        
                        Button(action: {
                            // Add to cart action
                            self.paymentHandler.startPayment(subtotal: Float(self.reservation.Total)) { (success) in
                                if success {
                                    // Call a method to display a pop-up for payment success
                                    self.paymentSuccess = true
                                    // Update the reservation status to "Payée"
                                    self.reservation.Statut = StatutRes.payee.rawValue
                                    // self.sendEmailConfirmation()
                                } else {
                                    print("Failed")
                                }
                            }
                        }) {
                            HStack {
                                Image(systemName: "creditcard") // Use the appropriate icon name
                                    .resizable()
                                    .scaledToFit()
                                    .foregroundColor(.green) // Change the color as needed
                                    .frame(width: 20, height: 20) // Adjust the size as needed

                                Text("Payer")
                                    .font(.body)
                                    .fontWeight(.medium)
                            }
                            .padding(8)
                            .background(Color.blue) // Change the background color as needed
                            .foregroundColor(.white) // Change the text color as needed
                            .cornerRadius(8)
                        }


                        Spacer()

                        Button(action: {
                            showDeleteConfirmation = true
                        }) {
                            Image(systemName: "trash") // Choisir le nom de l'icône que vous souhaitez
                                .resizable()
                                .scaledToFit()
                                .foregroundColor(.red) // Changer la couleur selon vos besoins
                                .frame(width: 20, height: 20) // Ajuster la taille selon vos besoins
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


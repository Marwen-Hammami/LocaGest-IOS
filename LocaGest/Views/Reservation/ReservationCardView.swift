import SwiftUI

struct ReservationCardView: View {
    var reservation: Reservation
    @EnvironmentObject var reservationModel: ReservationModel
    @State private var showDeleteConfirmation = false
    
    var body: some View {
        ZStack {
           /* LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)*/
            
            VStack(alignment: .leading, spacing: 8) {
                // reservation image
                Image("car1")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 200)
                    .clipped()
                
                // reservation details
                VStack(alignment: .leading, spacing: 8) {
                    // reservation title
                    Text("Voiture")
                        .font(.title)
                        .fontWeight(.medium)
                    
                    // HStack for date and info icons
                    HStack {
                        VStack {
//                            Text("STATUT: \(reservation.Statut.rawValue)")
                            Text("STATUT: \(reservation.Statut)")
                                .font(.body)
                                .fontWeight(.medium)
                            
                            // Button with the "info.circle" icon
                            NavigationLink(destination: ReservationDetailView(reservation: reservation, paymentHandler: PaymentHandler())) {
                                Image(systemName: "info.circle")
                                    .foregroundColor(.teal)
                            }/*}
                        VStack {*/
                         
                        }//***
                    }
                }
                .padding(16)
            }
            .background(Color.white)
            .cornerRadius(8)
            .shadow(radius: 4)
            .padding(8)
        }
    }
}

struct ReservationCardView_Previews: PreviewProvider {
    static var previews: some View {
        let reservationModel = ReservationModel()
        
        if let reservation = reservationModel.reservations.first {
            return AnyView(ReservationCardView(reservation: reservation)
                            .environmentObject(reservationModel))
        } else {
            return AnyView(Text("No reservation"))
        }
    }
}

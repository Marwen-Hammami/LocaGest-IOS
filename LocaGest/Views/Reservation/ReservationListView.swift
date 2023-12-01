import SwiftUI


struct ReservationListView: View {
    @StateObject private var reservationModel = ReservationModel(reservations: [
        Reservation(dateDebut: Date(), dateFin: Date(), heureDebut: "10:00 AM", heureFin: "12:00 PM", statut: .reservee, total: 100.0),
        Reservation(dateDebut: Date(), dateFin: Date(), heureDebut: "2:00 PM", heureFin: "4:00 PM", statut: .payee, total: 150.0),
        Reservation(dateDebut: Date(), dateFin: Date(), heureDebut: "6:00 PM", heureFin: "8:00 PM", statut: .achevee, total: 200.0)
    ])
    @State private var selectedReservation: Reservation?
    
    var body: some View {
        NavigationView {
            List(reservationModel.reservations) { reservation in
                Button(action: {
                    selectedReservation = reservation
                }) {
                    Text("Reservation ID: \(reservation.id)")
                }
            }
            .navigationTitle("Reservations")
            .sheet(item: $selectedReservation) { reservation in
                ReservationDetailView(reservation: reservation)
            }
        }
    }
}

struct ReservationDetailView: View {
    let reservation: Reservation
    
    var body: some View {
        VStack {
            Text("Reservation Details")
                .font(.title)
            
            Text("Start Date: \(reservation.dateDebut)")
            Text("End Date: \(reservation.dateFin)")
            Text("Start Time: \(reservation.heureDebut)")
            Text("End Time: \(reservation.heureFin)")
            Text("Status: \(reservation.statut.rawValue)")
            Text("Total: \(reservation.total)")
            
            Spacer()
        }
        .padding()
    }
}

struct ContentView: View {
    var body: some View {
        ReservationListView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

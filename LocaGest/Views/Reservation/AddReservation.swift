import SwiftUI

struct AddReservation: View {
    @Environment(\.presentationMode) var presentationMode
//    let addReservation: (Reservation) -> Void
    
    @State private var dateDebut = Date()
    @State private var dateFin = Date()
    @State private var heureDebut = 0
    @State private var heureFin = 0
    @State private var statut: StatutRes = .reserve
    
    var reservationTotal: Double {
//        let newReservation = Reservation(dateDebut: dateDebut, dateFin: dateFin, heureDebut: heureDebut, heureFin: heureFin, statut: statut)
//        return newReservation.total
        return 0.0
    }
    func saveReservation() {
//        let newReservation = Reservation(dateDebut: dateDebut, dateFin: dateFin, heureDebut: heureDebut, heureFin: heureFin, statut: statut)
//        addReservation(newReservation) // Ajoutez la réservation en utilisant la closure `addReservation`
        presentationMode.wrappedValue.dismiss() // Fermez la vue modale après avoir ajouté la réservation
    }
    
    var body: some View {
        VStack {
            Text("Ajouter une réservation")
                .font(.title)
                .padding()

            Form {
                Section(header: Text("Date et heure")) {
                    DatePicker("Date de début", selection: $dateDebut, displayedComponents: .date)
                    DatePicker("Date de fin", selection: $dateFin, displayedComponents: .date)

                    Picker("Heure de début", selection: $heureDebut) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour)h")
                        }
                    }

                    Picker("Heure de fin", selection: $heureFin) {
                        ForEach(0..<24, id: \.self) { hour in
                            Text("\(hour)h")
                        }
                    }
                }

                Section(header: Text("Statut")) {
                    Picker("Statut", selection: $statut) {
                        Text("Réservée").tag(StatutRes.reserve)
                        Text("Payée").tag(StatutRes.payee)
                        Text("Achevée").tag(StatutRes.achevee)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                }

                Section(header: Text("Total")) {
                    Text("Montant total : \(reservationTotal, specifier: "%.2f") EUR")
                }
                
                Button(action: saveReservation) { // Utilisez la fonction `saveReservation` pour l'action du bouton
                    Text("Add")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color("Accent"))
                        .cornerRadius(50)
                        .padding(.leading, 0)
                }
            }
        }
    }
}

//struct AddReservation_Previews: PreviewProvider {
//    static var previews: some View {
//        let reservationModel = ReservationModel() // Créez une instance de ReservationModel
//        AddReservation(reservationModel: reservationModel, addReservation: { _ in })
//    }
//}

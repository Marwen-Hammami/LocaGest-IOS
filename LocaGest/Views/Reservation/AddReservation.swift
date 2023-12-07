import SwiftUI

struct AddReservation: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dateDebut = Date()
    @State private var dateFin = Date()
    @State private var heureDebut = 0
    @State private var heureFin = 0
    @State private var statut: StatutRes = .reserve
    
    @ObservedObject var viewModel: ReservationViewModel

    var reservationTotal: Double {
        return 0.0
    }
    
    //    func saveReservation() {
    //        let newReservation = Reservation(
    //            _id: "",
    //            DateDebut: dateDebut,
    //            DateFin: dateFin,
    //            HeureDebut: "\(heureDebut)",
    //            HeureFin: "\(heureFin)",
    //            Statut: statut.rawValue,
    //            Total: reservationTotal
    //        )
    //
    //        viewModel.addReservation(newReservation)
    //        presentationMode.wrappedValue.dismiss()
    //    }
    
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
                
                Button(action: saveReservation) {
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
    
    
    
    func saveReservation() {
        let newReservation = ReservationRequest(
            _id: "",
            DateDebut: dateDebut,
            DateFin: dateFin,
            HeureDebut: heureDebut,
            HeureFin: heureFin,
            Statut: statut,
            Total: reservationTotal
        )

        // Appelez la méthode dans le modèle pour ajouter la réservation
        viewModel.addReservation(newReservation)
        
        // Fermez la vue
        presentationMode.wrappedValue.dismiss()
    }

    
    
      }
    
        
    
    


struct AddReservation_Previews: PreviewProvider {
    static var previews: some View {
        AddReservation(viewModel: ReservationViewModel())
    }
}

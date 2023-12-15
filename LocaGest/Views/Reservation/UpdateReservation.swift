import SwiftUI

struct UpdateReservation: View {
    let reservation : Reservation
    
    
    @Environment(\.presentationMode) var presentationMode
    @State private var dateDebut = Date()
    @State private var dateFin = Date()
    @State private var heureDebut = 0
    @State private var heureFin = 0
    @State private var statut: StatutRes = .reserve
    
   
   
    @StateObject var viewModel = ReservationViewModel()
    
    

    let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return formatter
    }()

    

    var reservationTotal: Double {
        // Calculate total based on editedReservation
        return 0.0
    }
    
   
    var body: some View {
        VStack {
            Text("Modifier la réservation")
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
            Statut: .reserve,
            Total: reservationTotal
           
        )

        // Appelez la méthode dans le modèle pour ajouter la réservation
        viewModel.updateReservation(reservation.id  , updatedReservation: newReservation)
        
        // Fermez la vue
        presentationMode.wrappedValue.dismiss()
    }

 
}


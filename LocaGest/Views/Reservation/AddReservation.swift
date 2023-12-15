import SwiftUI

struct AddReservation: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var dateDebut = Date()
    @State private var dateFin = Date()
    @State private var heureDebut = 0
    @State private var heureFin = 0

    @ObservedObject var viewModel: ReservationViewModel

    var reservationTotal: Double {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour, .minute], from: dateDebut, to: dateFin)
        let durationInHours = Double(components.hour ?? 0) + Double(components.minute ?? 0) / 60.0

        if durationInHours <= 24 {
            let hourlyRate = 10.0 // Remplacez par le tarif horaire réel
            let hours = max(heureFin - heureDebut, 0)
            return Double(hours) * hourlyRate
        } else {
            let dailyRate = 50.0 // Remplacez par le tarif journalier réel
            let numberOfDays = durationInHours / 24
            let remainingHours = max(heureFin - heureDebut - Int(numberOfDays) * 24, 0)
            let extraHourlyRate = dailyRate / 24.0

            let totalDailyRate = Double(numberOfDays) * dailyRate
            let totalExtraHourlyRate = Double(remainingHours) * extraHourlyRate

            return totalDailyRate + totalExtraHourlyRate
        }
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

                Section(header: Text("Total")) {
                    Text("Montant total : \(reservationTotal, specifier: "%.2f") EUR")
                }

                Button(action: saveReservation) {
                    Text("Add")
                        .font(.system(size: 20))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.teal)
                        .cornerRadius(50)
                        .padding(.leading, 0)
                }
            }
        }
        .background(
            Image("back1")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
        )
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

        viewModel.addReservation(newReservation)

        presentationMode.wrappedValue.dismiss()
    }
}

struct AddReservation_Previews: PreviewProvider {
    static var previews: some View {
        AddReservation(viewModel: ReservationViewModel())
    }
}

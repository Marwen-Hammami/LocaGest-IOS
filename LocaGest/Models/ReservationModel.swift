//
//  ReservationModel.swift
//  LocaGest
//
//  Created by jouhayna cheikh on 26/11/2023.
//

import Foundation
import Combine

enum StatutRes: String {
    case reserve = "Reservée"
    case payee = "Payée"
    case achevee = "Achevée"
}

class ReservationModel: ObservableObject {
    @Published var reservations: [Reservation] = []
        
        func addReservation(_ reservation: Reservation) {
            reservations.append(reservation)
        }
    func deleteReservation(at index: Int) {
        reservations.remove(at: index)
    }
    init() {
        
        // Ajouter une réservation fictive pour la prévisualisation
      /*  let dummyReservation = Reservation(dateDebut: Date(), dateFin: Date(), heureDebut: 09, heureFin: 12, statut: .reservee, total: 50.0)
        addReservation(dummyReservation)*/
    }
}

struct Reservation: Identifiable {
    let id = UUID() //id from swuift
    var _id: String //id from mongodb
    let DateDebut: String//Date
    let DateFin: String//Date
    let HeureDebut: String//Int
    let HeureFin: String//Int
    let Statut: String//StatutRes
    var Total: Double //{
//        let calendar = Calendar.current
//        let components = calendar.dateComponents([.hour], from: dateDebut, to: dateFin)
//        let durationInHours = components.hour ?? 0
//
//        if durationInHours <= 24 {
//            // Tarif horaire
//            let hourlyRate = 10.0 // Remplacez par le tarif horaire réel
//            let hours = max(heureFin - heureDebut, 0) // Durée en heures, avec un minimum de 0
//            return Double(hours) * hourlyRate
//        } else {
//            // Tarif journalier
//            let dailyRate = 50.0 // Remplacez par le tarif journalier réel
//            let numberOfDays = durationInHours / 24
//            let remainingHours = max(heureFin - heureDebut - numberOfDays * 24, 0) // Heures restantes, avec un minimum de 0
//            let extraHourlyRate = dailyRate / 24.0 // Tarif horaire pour les heures supplémentaires
//
//            let totalDailyRate = Double(numberOfDays) * dailyRate
//            let totalExtraHourlyRate = Double(remainingHours) * extraHourlyRate
//
//            return totalDailyRate + totalExtraHourlyRate
//        }
//    }
    
    init?(json: [String: Any]) {
        guard
            let _id = json["_id"] as? String,
            let dateDebut = json["DateDebut"] as? String,
            let dateFin = json["DateFin"] as? String,
            let heureDebut = json["HeureDebut"] as? String,
            let heureFin = json["HeureFin"] as? String,
            let Statut = json["Statut"] as? String,
            let Total = json["Total"] as? Double
        else {
            return nil
        }

        self._id = _id
        self.DateDebut = dateDebut
        self.DateFin = dateFin
        self.HeureDebut = heureDebut
        self.HeureFin = heureFin
        self.Statut = Statut
        self.Total = Total
    }

}

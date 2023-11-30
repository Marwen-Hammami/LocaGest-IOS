//
//  ReservationModel.swift
//  LocaGest
//
//  Created by jouhayna cheikh on 26/11/2023.
//

import Foundation
import Combine

enum StatutRes: String {
    case annulee = "Annulée"
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
    let id = UUID()
    let dateDebut: Date
    let dateFin: Date
    let heureDebut: Int
    let heureFin: Int
    let statut: StatutRes
    var total: Double {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.hour], from: dateDebut, to: dateFin)
        let durationInHours = components.hour ?? 0
        
        if durationInHours <= 24 {
            // Tarif horaire
            let hourlyRate = 10.0 // Remplacez par le tarif horaire réel
            let hours = max(heureFin - heureDebut, 0) // Durée en heures, avec un minimum de 0
            return Double(hours) * hourlyRate
        } else {
            // Tarif journalier
            let dailyRate = 50.0 // Remplacez par le tarif journalier réel
            let numberOfDays = durationInHours / 24
            let remainingHours = max(heureFin - heureDebut - numberOfDays * 24, 0) // Heures restantes, avec un minimum de 0
            let extraHourlyRate = dailyRate / 24.0 // Tarif horaire pour les heures supplémentaires
            
            let totalDailyRate = Double(numberOfDays) * dailyRate
            let totalExtraHourlyRate = Double(remainingHours) * extraHourlyRate
            
            return totalDailyRate + totalExtraHourlyRate
        }
    }
}

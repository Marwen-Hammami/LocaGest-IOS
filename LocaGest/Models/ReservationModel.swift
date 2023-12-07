//
//  ReservationModel.swift
//  LocaGest
//
//  Created by jouhayna cheikh on 26/11/2023.
//

import Foundation
import Combine

enum StatutRes: String {
    case reserve = "Réservée"
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
        
      
    }
}

struct Reservation: Identifiable {
    var id: String
    
    let DateDebut: String//Date
    let DateFin: String//Date
    let HeureDebut: String//Int
    let HeureFin: String//Int
    let Statut: String//StatutRes
    private(set) var Total: Double {
           get {
               let dateFormatter = DateFormatter()
               dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
               guard let startDate = dateFormatter.date(from: "\(DateDebut) \(HeureDebut):00:00"),
                     let endDate = dateFormatter.date(from: "\(DateFin) \(HeureFin):00:00") else {
                   return 0.0
               }
               
               let calendar = Calendar.current
               let components = calendar.dateComponents([.hour], from: startDate, to: endDate)
               let durationInHours = components.hour ?? 0
               
               if durationInHours <= 24 {
                   // Hourly rate
                   let hourlyRate = 10.0 // Replace with the actual hourly rate
                   let hours = max(Int(HeureFin)! - Int(HeureDebut)!, 0) // Duration in hours, with a minimum of 0
                   return Double(hours) * hourlyRate
               } else {
                   // Daily rate
                   let dailyRate = 50.0 // Replace with the actual daily rate
                   let numberOfDays = durationInHours / 24
                   let remainingHours = max(Int(HeureFin)! - Int(HeureDebut)! - numberOfDays * 24, 0) // Remaining hours, with a minimum of 0
                   let extraHourlyRate = dailyRate / 24.0 // Hourly rate for extra hours

                   let totalDailyRate = Double(numberOfDays) * dailyRate
                   let totalExtraHourlyRate = Double(remainingHours) * extraHourlyRate

                   return totalDailyRate + totalExtraHourlyRate
               }
           }
           set {
               // You can set the total value internally if needed
               // For example:
               // self.Total = newValue
           }
       }
    
    init?(json: [String: Any]) {
        guard
            let id = json["_id"] as? String,
            let dateDebut = json["DateDebut"] as? String,
            let dateFin = json["DateFin"] as? String,
            let heureDebut = json["HeureDebut"] as? String,
            let heureFin = json["HeureFin"] as? String,
            let Statut = json["Statut"] as? String,
            let Total = json["Total"] as? Double
        else {
            return nil
        }

        self.id = id
        self.DateDebut = dateDebut
        self.DateFin = dateFin
        self.HeureDebut = heureDebut
        self.HeureFin = heureFin
        self.Statut = Statut
        self.Total = Total
    }

}

//
//  ReservationRequest.swift
//  LocaGest
//
//  Created by jouhayna cheikh on 7/12/2023.
//

import Foundation

struct ReservationRequest: Identifiable {
    let id = UUID() //id from swuift
    var _id: String //id from mongodb
    let DateDebut: Date//Date
    let DateFin: Date//Date
    let HeureDebut: Int//Int
    let HeureFin: Int//Int
    let Statut: StatutRes//StatutRes
    private(set) var Total: Double
    
//        get {
//            let dateFormatter = DateFormatter()
//            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
//            guard let startDate = dateFormatter.date(from: "\(DateDebut) \(HeureDebut):00:00"),
//                  let endDate = dateFormatter.date(from: "\(DateFin) \(HeureFin):00:00") else {
//                return 0.0
//            }
//
//            let calendar = Calendar.current
//            let components = calendar.dateComponents([.hour], from: startDate, to: endDate)
//            let durationInHours = components.hour ?? 0
//
//            if durationInHours <= 24 {
//                // Hourly rate
//                let hourlyRate = 10.0 // Replace with the actual hourly rate
//                let hours = max(Int(HeureFin)! - Int(HeureDebut)!, 0) // Duration in hours, with a minimum of 0
//                return Double(hours) * hourlyRate
//            } else {
//                // Daily rate
//                let dailyRate = 50.0 // Replace with the actual daily rate
//                let numberOfDays = durationInHours / 24
//                let remainingHours = max(Int(HeureFin)! - Int(HeureDebut)! - numberOfDays * 24, 0) // Remaining hours, with a minimum of 0
//                let extraHourlyRate = dailyRate / 24.0 // Hourly rate for extra hours
//
//                let totalDailyRate = Double(numberOfDays) * dailyRate
//                let totalExtraHourlyRate = Double(remainingHours) * extraHourlyRate
//
//                return totalDailyRate + totalExtraHourlyRate
//            }
//        }
//        set {
//            // You can set the total value internally if needed
//            // For example:
//            // self.Total = newValue
//        }
//    }
}
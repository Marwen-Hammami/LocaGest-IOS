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
    
    var DateDebut: String//Date
    var DateFin: String//Date
    let HeureDebut: String//Int
    let HeureFin: String//Int
    var Statut: String//StatutRes
    private(set) var Total: Double 
    
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

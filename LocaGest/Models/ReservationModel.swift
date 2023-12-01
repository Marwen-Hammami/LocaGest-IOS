//
//  ReservationModel.swift
//  LocaGest
//
//  Created by jouhayna cheikh on 26/11/2023.
//

import Foundation

enum StatutRes: String {
    case reservee = "Réservée"
    case payee = "Payée"
    case achevee = "Achevée"
}

class ReservationModel: ObservableObject {
    @Published var reservations: [Reservation]
    
    init(reservations: [Reservation]) {
        self.reservations = reservations
    }
}

struct Reservation:Identifiable {
    let id = UUID()
    let dateDebut: Date
    let dateFin: Date
    let heureDebut: String
    let heureFin: String
    let statut: StatutRes
    let total: Double
}

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
    let DateDebut: Date //Date
    let DateFin: Date //Date
    let HeureDebut: Int //Int
    let HeureFin: Int //Int
    var Statut: StatutRes //StatutRes

    var Total: Double 
}

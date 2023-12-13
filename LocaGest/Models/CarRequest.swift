//
//  CarRequest.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 7/12/2023.
//

import Foundation
struct CarRequest: Encodable {
    //var id: String?
    var immatriculation: String
    var marque: String
    var modele: String
    var image: String
    var cylindree: String
    var etatVoiture: String
    var type: String
    var prixParJour: Int
}

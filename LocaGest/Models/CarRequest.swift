//
//  CarRequest.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 7/12/2023.
//

import Foundation
struct CarRequest: Identifiable, Codable {
    let id: UUID
    var immatriculation: String?
    var marque: String
    var modele: String
     var carburant: String
     var boite: String
  
   
}

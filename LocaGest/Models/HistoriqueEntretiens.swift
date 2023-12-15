//
//  HistoriqueEntretiens.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 29/11/2023.
//

import Foundation

struct HistoriqueEntretiens: Decodable, Encodable, Identifiable {
    let id: String
    var immatriculation: String
    var cartype: String
    var titre: String
    var date_entretien: String?
    var description: String?
    var cout_reparation: Int?
    var image: String
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case immatriculation, cartype, titre, date_entretien, description, cout_reparation, image
    }
}


//
//  Agence.swift
//  LocaGest
//
//  Created by Skander Guedri on 29/11/2023.
//

import Foundation

struct Agence: Identifiable {
    var id: String
    let agenceName: String
    let adresse: String
    let idHead: String?
    let longitude: Double
    let latitude: Double

    init?(json: [String: Any]) {
        guard
            let agenceName = json["AgenceName"] as? String,
            let adresse = json["Adresse"] as? String,
            let id = json["_id"] as? String,
            let longitude = json["longitude"] as? Double,
            let latitude = json["latitude"] as? Double
        else {
            return nil
        }

        self.id = id
        self.agenceName = agenceName
        self.adresse = adresse
        self.idHead = json["IdHead"] as? String
        self.longitude = longitude
        self.latitude = latitude
    }
}


//
//  Car.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 28/11/2023.
//
import Foundation

struct Car: Identifiable, Codable {
    let id: UUID
    var immatriculation: String?
    var marque: String
    var modele: String
    var carburant: Carburant
    var boite: Boite
    var disponibility: Disponibility

    init?(json: [String: Any]) {
        guard
            let idString = json["id"] as? String,
            let idUUID = UUID(uuidString: idString),
            let immatriculation = json["immatriculation"] as? String,
            let marque = json["marque"] as? String,
            let modele = json["modele"] as? String,
            let carburantRawValue = json["carburant"] as? String,
            let carburant = Carburant(rawValue: carburantRawValue),
            let boiteRawValue = json["boite"] as? String,
            let boite = Boite(rawValue: boiteRawValue),
            let disponibilityRawValue = json["disponibility"] as? String,
            let disponibility = Disponibility(rawValue: disponibilityRawValue)
        else {
            return nil
        }

        self.id = idUUID
        self.immatriculation = immatriculation
        self.marque = marque
        self.modele = modele
        self.carburant = carburant
        self.boite = boite
        self.disponibility = disponibility
    }
}

enum Carburant: String, Codable {
    case essence = "Essence"
    case diesel = "Diesel"
    case hybride = "Hybride"
}

enum Boite: String, Codable {
    case manuelle = "Manuelle"
    case automatique = "Automatique"
}

enum Disponibility: String, Codable {
    case disponible = "Disponible"
    case louee = "Louée"
}





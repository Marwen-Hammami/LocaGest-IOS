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
    var carburant: String
    var boite: String
    var disponibility: String

    init?(json: [String: Any]) {
        guard
            let _id = json["_id"] as? String,
            let idUUID = UUID(uuidString: _id),
            let immatriculation = json["immatriculation"] as? String,
            let marque = json["marque"] as? String,
            let modele = json["modele"] as? String,
            let carburant = json["carburant"] as? String,
            let boite = json["boite"] as? String,
            let disponibility = json["disponibility"] as? String
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


//enum Carburant: String, Codable {
   // case essence = "Essence"
   // case diesel = "Diesel"
   // case hybride = "Hybride"
//}

//enum Boite: String, Codable {
    //case manuelle = "Manuelle"
    //case automatique = "Automatique"
//}

//enum Disponibility: String, Codable {
    //case disponible = "Disponible"
   // case louee = "Louée"
//}





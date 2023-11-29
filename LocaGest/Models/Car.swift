//
//  Car.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 28/11/2023.
//
import Foundation
struct Car: Identifiable {
    let id: UUID
    var immatriculation: String?
    var marque: String
    var modele: String
    var carburant: Carburant
    var boite: Boite
    var disponibility: Disponibility
    
}

enum Carburant: String {
    case essence = "Essence"
    case diesel = "Diesel"
    case hybride = "Hybride"
}

enum Boite: String {
    case manuelle = "Manuelle"
    case automatique = "Automatique"
}
enum Disponibility: String {
    case disponible = "Disponible"
    case louee = "Louée"
}




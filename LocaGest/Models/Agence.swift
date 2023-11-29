//
//  Agence.swift
//  LocaGest
//
//  Created by Skander Guedri on 29/11/2023.
//

import Foundation

struct Agence:Identifiable {
    var id = UUID()
    let agenceName: String
    let adresse: String
    let idHead: String
    let longitude: String
    let latitude: String
}

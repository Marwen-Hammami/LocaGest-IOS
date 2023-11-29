//
//  HistoriqueEntretiens.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 29/11/2023.
//

import Foundation
struct HistoriqueEntretiens: Identifiable {
    let id: UUID
    var ident: String?
    var titre: String
    var description: String
    var cout: Int
}

//
//  SideBarViewModel.swift
//  LocaGest
//
//  Created by Karim Hammami on 25/11/2023.
//

import Foundation

class ViewModel:ObservableObject{
    @Published var isopen: Bool = false
    @Published var sideButton: Bool = true
    @Published var selecteditem: TabIcon = .user
    @Published var toggleAction = false
}

struct sideBar:Identifiable{
    var id = UUID()
    var icon: String
    var titel: String
    var tab: TabIcon
}

var sidebar = [
    sideBar(icon: "person", titel: "User-Maher", tab: .user),
    sideBar(icon: "house", titel: "Agence-Skander", tab: .agence),
    sideBar(icon: "car", titel: "Flotte-Maamoun", tab: .flotte),
    sideBar(icon: "doc.richtext", titel: "Reservation-Jouhayna", tab: .reservation),
    sideBar(icon: "wrench", titel: "Garage-Chiheb", tab: .garage),
    sideBar(icon: "message", titel: "Chat-Marwen", tab: .chat)
]

enum TabIcon: String{
    case user
    case agence
    case flotte
    case reservation
    case garage
    case chat
}

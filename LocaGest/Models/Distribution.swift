//
//  Distribution.swift
//  LocaGest
//
//  Created by Mac Mini 6 on 28/11/2023.
//

import Foundation
struct Distribution: Identifiable{
    let id: UUID
    var typeRepair: String
    let pieces: Tool
    let cars: Car
    var description: String
    var technicien: User
    var startDate: Date?
    var endDate: Date?
    var statusCar: String
}

enum typeRepair: String {
    case maintenance = "Maintenance"
    case repair = "Repair"
    case carWash = "Car Wash"

}
enum status: String {
    case inProgress = "In Progress"
    case delivred = "Delivred"
}



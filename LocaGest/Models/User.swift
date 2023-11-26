import Foundation

struct User: Identifiable {
    let id: UUID
    var username: String?
    let email: String
    let password: String
    var firstName: String?
    var lastName: String?
    var creditCardNumber: Int?
    var rate: Rate
    var specialization: String?
    var experience: Int?
    var roles: Role
    var isVerified: Bool
    var phoneNumber: String?
    var resetToken: String?
    var resetTokenExpiration: Date?
    var otpCode: String?
    var otpExpiration: Date?
}

enum Rate: String {
    case good = "GOOD"
    case average = "AVERAGE"
    case bad = "BAD"
}

enum Role: String {
    case technician = "technician"
    case admin = "admin"
    case client = "client"
}

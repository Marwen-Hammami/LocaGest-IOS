struct User: Codable {
    let id: String?
    let username: String?
    let email: String
    let password: String
    var firstName: String? = nil
    var lastName: String? = nil
    var rate: Rate = .good
    var specialization: String? = nil
    var experience: Int? = nil
    var roles: Role = .client
    var isVerified: Bool = false
    let phoneNumber: String?
    let image: String?
    var creditCardNumber: Int? = nil
    
    init(username: String?, email: String, password: String, phoneNumber: String?, id: String? = nil, image: String? = nil) {
            self.username = username
            self.email = email
            self.password = password
            self.phoneNumber = phoneNumber
            self.id = id
            self.image = image
        }
}
enum Rate: String, Codable {
    case good = "GOOD"
    case average = "AVERAGE"
    case bad = "BAD"
}

enum Role: String, Codable {
    case technician = "technician"
    case admin = "admin"
    case client = "client"
}

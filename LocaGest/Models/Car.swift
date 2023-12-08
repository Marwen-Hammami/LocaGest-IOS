import Foundation

struct Car: Decodable, Identifiable {
    let id: String
    var immatriculation: String
    var marque: String
    var modele: String
    var image: String
    var cylindree: String // Corrected the property name
    var etatVoiture: String
    var type: String
    var prixParJour: Int
    
    enum CodingKeys: String, CodingKey {
        case id = "_id"
        case immatriculation, marque, modele, image, cylindree, etatVoiture, type, prixParJour
    }
}

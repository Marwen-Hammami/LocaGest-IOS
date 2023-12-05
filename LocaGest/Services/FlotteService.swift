//
//  Agence.swift
//  LocaGest
//
// 
//

import Foundation

class FlotteService {
    static let shared = FlotteService()
    private let baseURL = "https://locagest.onrender.com"

    func fetchCars(completion: @escaping ([Car]?) -> Void) {
        let url = URL(string: "\(baseURL)/flotte")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                print("Error fetching cars:", error?.localizedDescription ?? "Unknown error")
                completion(nil)
                return
            }

            do {
                let decoder = JSONDecoder()
                let cars = try decoder.decode([Car].self, from: data)
                completion(cars)
            } catch let decodingError {
                print("Error decoding cars:", decodingError.localizedDescription)
                completion(nil)
            }
        }.resume()
    }
}


    // Fetch product details by ID
//       func fetchAgencessDetails(id: String, completion: @escaping (Product?) -> Void) {
//           let url = URL(string: "\(baseURL)/produit/detail?id=\(id)")!
//
//           URLSession.shared.dataTask(with: url) { data, response, error in
//               guard let data = data, error == nil else {
//                   completion(nil)
//                   return
//               }
//
//               do {
//                   if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
//                       if let product = Product(json: json) {
//                           completion(product)
//                       } else {
//                           completion(nil)
//                       }
//                   } else {
//                       completion(nil)
//                   }
//               } catch {
//                   completion(nil)
//               }
//           }.resume()
//       }


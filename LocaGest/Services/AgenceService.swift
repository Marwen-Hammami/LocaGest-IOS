//
//  Agence.swift
//  LocaGest
//
//  Created by Skander Guedri on 30/11/2023.
//

import Foundation

class AgenceService {
    static let shared = AgenceService()
    private let baseURL = "https://locagest.onrender.com"

    func fetchAgencess(completion: @escaping ([Agence]?) -> Void) {
        let url = URL(string: "\(baseURL)/agence")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }

            do {
                if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                    print("jsonArray-----------")
                    print(jsonArray)
                    let agences = jsonArray.compactMap {
                        Agence(json: $0) }
                    print("agences---------------")
                    print(agences)
                    completion(agences)
                } else {
                    completion(nil)
                }
            } catch let error{
                print("*****User creation failed with error: \(error)")
                completion(nil)
            }
        }.resume()
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
}

//
//  Agence.swift
//  LocaGest
//
// 
//

import Foundation

class FlotteService {
    static let shared = FlotteService()
    private let baseURL = "http://localhost:9090/car"

    func createCar(car: Car, completion: @escaping (Result<Car, Error>) -> Void) {
        let url = URL(string: "\(baseURL)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalCacheData // Ignore local cache
        
        do {
            let jsonData = try JSONEncoder().encode(car)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let createdCar = try JSONDecoder().decode(Car.self, from: data)
                        completion(.success(createdCar))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    func getCars(completion: @escaping (Result<[Car], Error>) -> Void) {
        let url = URL(string: "\(baseURL)")!
        
        var request = URLRequest(url: url)
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control") // Do not use cache
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                do {
                    let cars = try JSONDecoder().decode([Car].self, from: data)
                    completion(.success(cars))
                } catch {
                    completion(.failure(error))
                }
            } else if let error = error {
                completion(.failure(error))
            }
        }.resume()
    }

    func updateCar(immatriculation: String, car: Car, completion: @escaping (Result<Car, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/\(immatriculation)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.cachePolicy = .reloadIgnoringLocalCacheData // Ignore local cache
        
        do {
            let jsonData = try JSONEncoder().encode(car)
            request.httpBody = jsonData
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    do {
                        let updatedCar = try JSONDecoder().decode(Car.self, from: data)
                        completion(.success(updatedCar))
                    } catch {
                        completion(.failure(error))
                    }
                } else if let error = error {
                    completion(.failure(error))
                }
            }.resume()
        } catch {
            completion(.failure(error))
        }
    }

    func deleteCar(immatriculation: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let url = URL(string: "\(baseURL)/\(immatriculation)")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"
        request.cachePolicy = .reloadIgnoringLocalCacheData // Ignore local cache
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let _ = data {
                completion(.success(()))
            } else if let error = error {
                completion(.failure(error))
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


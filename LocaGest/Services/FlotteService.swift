//
//  Agence.swift
//  LocaGest
//
//
//

import Foundation

final class FlotteService {
    static let shared = FlotteService()
    private let baseURL = "http://localhost:9090/car"

    func createCar(car: CarRequest, completion: @escaping (Result<Car, Error>) -> Void) {
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

    
    
    

    
//    func updateCar(immatriculation: String, car: Car, completion: @escaping (Result<Car, Error>) -> Void) {
//        let url = URL(string: "\(baseURL)/\(immatriculation)")!
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "PUT"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.cachePolicy = .reloadIgnoringLocalCacheData // Ignore local cache
//
//        do {
//            let jsonData = try JSONEncoder().encode(car)
//            request.httpBody = jsonData
//
//            URLSession.shared.dataTask(with: request) { data, response, error in
//                if let data = data {
//                    do {
//                        let updatedCar = try JSONDecoder().decode(Car.self, from: data)
//                        completion(.success(updatedCar))
//                    } catch {
//                        completion(.failure(error))
//                    }
//                } else if let error = error {
//                    completion(.failure(error))
//                }
//            }.resume()
//        } catch {
//            completion(.failure(error))
//        }
//    }
//
    
    static func deleteCar(immatriculation: String) async throws {
            let urlString = "http://localhost:9090/car/\(immatriculation)"

            guard let url = URL(string: urlString) else {
                throw NetworkError.invalidURL
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            do {
                let (_, response) = try await URLSession.shared.data(for: request)

                guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 204 else {
                    throw NetworkError.invalidResponse
                }
            } catch {
                throw NetworkError.requestFailed(error)
            }
        }
    
    
    
    
    static func getCars() async throws -> [Car] {
        let urlString = "http://localhost:9090/car/"

        guard let url = URL(string: urlString) else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = "GET"

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                throw NetworkError.invalidResponse
            }

            let decoder = JSONDecoder()
            let cars = try decoder.decode([Car].self, from: data)
            return cars
        } catch {
            throw NetworkError.requestFailed(error)
        }
    }
    enum NetworkError: Error {
        case invalidURL
        case invalidResponse
        case requestFailed(Error)
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


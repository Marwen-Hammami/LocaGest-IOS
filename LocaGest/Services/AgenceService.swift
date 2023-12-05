//
//  Agence.swift
//  LocaGest
//
//  Created by Skander Guedri on 30/11/2023.
//

import Foundation

class AgenceService {
    static let shared = AgenceService()
    private let baseURL = "http://172.20.10.12:9090"

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

        func deleteAgence(agencyID: String, completion: @escaping (Error?) -> Void) {
            // Define the API endpoint URL for deleting an agency using the agencyID
            let apiUrlString = "http://172.20.10.12:9090/agence/\(agencyID)" // Utilize the URL with the agencyID for deletion

            // Create the URL
            guard let url = URL(string: apiUrlString) else {
                completion(nil)
                return
            }

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "DELETE" // Use DELETE or the appropriate HTTP method for deletion

            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    completion(error)
                    return
                }

                // Check for a successful HTTP response
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Agence deleted successfully
                    completion(nil)
                } else {
                    // Agence deletion failed
                    completion(nil)
                }
            }.resume()
        }

        func updateAgence(agencyID: String, updatedData:Agence, completion: @escaping (Error?) -> Void) {
            // Define the API endpoint URL for updating an agency using the agencyID
            
            let updatedDataDict: [String: Any] = [
                   "AgenceName": updatedData.agenceName,
                   "Adresse": updatedData.adresse,
                   "IdHead": updatedData.idHead,
                   "longitude": updatedData.longitude,
                   "latitude": updatedData.latitude
                   // Add other properties of Agence here as needed
               ]
            let apiUrlString = "http://172.20.10.12:9090/agence/\(agencyID)" // Utilize the URL with the agencyID for updating

            // Create the URL
            guard let url = URL(string: apiUrlString) else {
                completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"]))
                return
            }

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "PUT" // Use PUT or the appropriate HTTP method for update

            // Set the Content-Type header
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                // Convert the updatedData to JSON data
                let jsonData = try JSONSerialization.data(withJSONObject: updatedDataDict)
                request.httpBody = jsonData
            } catch {
                completion(error)
                return
            }

            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                // Check for errors
                if let error = error {
                    completion(error)
                    return
                }

                // Check for a successful HTTP response
                if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                    // Agence updated successfully
                    completion(nil)
                } else {
                    // Agence update failed
                    completion(NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Failed to update agency"]))
                }
            }.resume()
        }
    

}


//
//  MessagesViewModel.swift
//  LocaGest
//
//  Created by Karim Hammami on 07/12/2023.
//

import Foundation
import UIKit

class MessagesViewModel: ObservableObject {
    @Published var messages: [Message]? = nil
    
//    let BASE_URL = "https://locagest.onrender.com"
    let BASE_URL = "http://192.168.155.177:9090"

    func fetchMessages(forConvID convID: String) {
        guard let url = URL(string: "\(BASE_URL)/messages/\(convID)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
//                    print("jsonArray-----------------")
//                    print(jsonArray ?? "no jsonArray")
                    let messages = jsonArray?.compactMap { Message(json: $0) }
//                    print("messages------------------")
//                    print(messages ?? "no messages")
                    self.messages = messages
                } catch {
                    self.messages = nil
                }
            }
        }.resume()
    }
    
    func addMessage(conversationId: String, sender: String, text: String, file: [String]) {
            guard let url = URL(string: "\(BASE_URL)/messages/") else {
                return
            }

            // Create the request
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            // Create the request body
            let requestBody: [String: Any] = [
                "conversationId": conversationId,
                "sender": sender,
                "text": text,
                "file": file
            ]

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
            } catch {
                print("Error encoding request body: \(error)")
                return
            }

            // Perform the request
            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        print("Error performing POST request: \(error?.localizedDescription ?? "Unknown error")")
                        return
                    }

                    self.fetchMessages(forConvID: conversationId)
                }
            }.resume()
        }
    
    func addMessageWithImage(conversationId: String, sender: String, text: String, file: [UIImage]?) {
        guard let url = URL(string: "\(BASE_URL)/messages/") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"

        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()

        // Add other parameters to the request body
        let params = [
            "conversationId": conversationId,
            "sender": sender,
            "text": text
        ]

        for (key, value) in params {
            body.append("--\(boundary)\r\n".data(using: .utf8)!)
            body.append("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n".data(using: .utf8)!)
            body.append("\(value)\r\n".data(using: .utf8)!)
        }

        // Add images to the request body
        if let file = file {
            for (index, image) in file.enumerated() {
                if let imageData = image.jpegData(compressionQuality: 0.8) {
                    body.append("--\(boundary)\r\n".data(using: .utf8)!)
                    body.append("Content-Disposition: form-data; name=\"file[\(index)]\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
                    body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
                    body.append(imageData)
                    body.append("\r\n".data(using: .utf8)!)
                }
            }
        }

        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Error performing POST request: \(error?.localizedDescription ?? "Unknown error")")
                    return
                }

                self.fetchMessages(forConvID: conversationId)
            }
        }.resume()
    }


    
    func deleteMessage(messageId: String, completion: @escaping (Result<Void, Error>) -> Void) {
            guard let url = URL(string: "\(BASE_URL)/messages/\(messageId)") else {
                return
            }

            var request = URLRequest(url: url)
            request.httpMethod = "DELETE"

            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    if let error = error {
                        completion(.failure(error))
                        return
                    }

                    if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                        // Successful deletion
                        completion(.success(()))
                    } else {
                        let unknownError = NSError(domain: "UnknownError", code: 0, userInfo: nil)
                        completion(.failure(unknownError))
                    }
                }
            }.resume()
        }
    
    func signalerMessage(messageId: String, signaleurId: String, raison: String, raisonAutre: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(BASE_URL)/messages/signalements") else {
            return
        }

        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        // Create the request body
        let requestBody: [String: Any] = [
            "messageId": messageId,
            "signaleurId": signaleurId,
            "raison": raison,
            "raisonAutre": raisonAutre
        ]

        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("Error encoding request body: \(error)")
            completion(.failure(error))
            return
        }

        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Error performing POST request: \(error?.localizedDescription ?? "Unknown error")")
                    completion(.failure(error ?? NSError(domain: "UnknownError", code: 0, userInfo: nil)))
                    return
                }

                if let responseString = String(data: data, encoding: .utf8) {
                    // Handle the response string
                    completion(.success(responseString))
                } else {
                    let decodingError = NSError(domain: "DecodingError", code: 0, userInfo: nil)
                    completion(.failure(decodingError))
                }
            }
        }.resume()
    }


}

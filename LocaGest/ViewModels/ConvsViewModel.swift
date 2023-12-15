//
//  ConvsViewModel.swift
//  LocaGest
//
//  Created by Karim Hammami on 05/12/2023.
//

import Foundation


class ConvsViewModel: ObservableObject {
    @Published var conversations: [Conversation]? = nil
    
    //    let BASE_URL = "https://locagest.onrender.com"
        let BASE_URL = "http://192.168.155.177:9090"

    func fetchConversations(forUserID userID: String) {
        guard let url = URL(string: "\(BASE_URL)/conversations/\(userID)") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    let conversations = jsonArray?.compactMap { Conversation(json: $0) }
                    
                    self.conversations = conversations
                } catch {
                    self.conversations = nil
                }
            }
        }.resume()
    }
    
    func addConversation(members: [String], isGroup: Bool) {
            guard let url = URL(string: "\(BASE_URL)/conversations") else {
                return
            }

            let parameters: [String: Any] = [
                "members": members,
                "isGroup": isGroup,
            ]

            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")

            do {
                request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
            } catch let error {
                print("Error serializing parameters: \(error.localizedDescription)")
                return
            }

            URLSession.shared.dataTask(with: request) { data, response, error in
                DispatchQueue.main.async {
                    guard let data = data, error == nil else {
                        // Handle error
                        return
                    }

                    do {
                        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        let userID = UserDefaults.standard.string(forKey: "UserID")
                        self.fetchConversations(forUserID: userID!)
                    } catch {
                        // Handle error
                    }
                }
            }.resume()
        }
    }


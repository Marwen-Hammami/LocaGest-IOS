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
}

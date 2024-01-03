//
//  EntretienService.swift
//  LocaGest
//
//  Created by Mohamed Maamoun Jrad  on 14/12/2023.
//

import Foundation

final class EntretienService {
    static let shared = EntretienService()
    private let baseURL = "https://locagest.onrender.com/historique_entretien"
    
    func getEntretiens() async throws -> [HistoriqueEntretiens] {
        let url = URL(string: "\(baseURL)")!

        var request = URLRequest(url: url)
        request.addValue("no-cache", forHTTPHeaderField: "Cache-Control") // Do not use cache

        do {
            let (data, _) = try await URLSession.shared.data(for: request)
            let jsonString = String(data: data, encoding: .utf8)
            print("JSON String: \(jsonString ?? "Empty")")

            print("data-------------------")
            print(data)
            let historiqueEntretiens = try JSONDecoder().decode([HistoriqueEntretiens].self, from: data)
            print("historiqueEntretiens-------------------")
            print(historiqueEntretiens)
            return historiqueEntretiens
        } catch {
            throw error
        }
    }



}


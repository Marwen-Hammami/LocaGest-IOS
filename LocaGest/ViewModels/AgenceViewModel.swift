//
//  AgenceViewModel.swift
//  LocaGest
//
//  Created by Skander Guedri on 30/11/2023.
//

import Foundation

class AgenceViewModel: ObservableObject {
    @Published var agences: [Agence]?

    init() {
        fetchAgencess()
    }
    
    func fetchAgencess() {
        AgenceService.shared.fetchAgencess { [weak self] agences in
            DispatchQueue.main.async {
                self?.agences = agences
                print(self?.agences)
                print("here")
            }
        }
    }

}


//    func fetchProductDetails(id: String, completion: @escaping (Product?) -> Void) {
//           ProductService.shared.fetchProductDetails(id: id) { product in
//               DispatchQueue.main.async {
//                   completion(product)
//               }
//           }
//       }

import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservations: [Reservation]?

    func fetchReservations() {
        guard let url = URL(string: "http://192.168.155.177:9090/res") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    print("Error fetching reservations : \(String(describing: error))")
                    return
                }

                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    let reservations = jsonArray?.compactMap { Reservation(json: $0) }

                    self.reservations = reservations
                    print("reservationsJSON------------------")
                    print(jsonArray ?? "no json")
                    print("reservations----------------------")
                    print(reservations ?? "no res")
                    print("self.reservations-----------------")
                    print(self.reservations ?? "no self res")
                } catch {
                    self.reservations = nil
                }
            }
        }.resume()
    }
    
    
    func addReservation(_ reservation: ReservationRequest) {
        // Define the API endpoint URL
        let apiUrlString = "http://192.168.155.177:9090/res/"
        
        // Create the URL
        guard let url = URL(string: apiUrlString) else {
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        
        // Create the request body
        let requestBody: [String: Any] = [
            "DateDebut": dateFormatter.string(from: reservation.DateDebut),
            "DateFin": dateFormatter.string(from: reservation.DateFin),
            "HeureDebut": reservation.HeureDebut,
            "HeureFin": reservation.HeureFin,
            "Statut": reservation.Statut.rawValue,
            "Total": 0.0
        ]
        
        do {
            // Convert the request body to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            return
        }
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error adding reservation: \(error)")
                //completion(false)
                return
            }
            
            // Check for a successful HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // Reservation added successfully
               // completion(true)
            } else {
                // Reservation addition failed
               // completion(false)
            }
        }.resume()
    }
    
    
    
    func deleteReservation(reservationID: String, completion: @escaping (Error?) -> Void) {
        // Définir l'URL de l'API pour supprimer une réservation en utilisant l'ID de la réservation
        let apiUrlString = "http://192.168.155.177:9090/res/\(reservationID)"

        // Créer l'URL
        guard let url = URL(string: apiUrlString) else {
            completion(NSError(domain: "Invalid URL", code: 0, userInfo: nil))
            return
        }

        // Créer la requête
        var request = URLRequest(url: url)
        request.httpMethod = "DELETE"

        // Effectuer la requête
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Vérifier les erreurs de réseau
            if let error = error {
                completion(error)
                return
            }

            // Vérifier la réponse HTTP
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(NSError(domain: "Invalid HTTP Response", code: 0, userInfo: nil))
                return
            }

            // Analyser la réponse HTTP
            switch httpResponse.statusCode {
            case 200:
                // Réservation supprimée avec succès
                completion(nil)
            case 404:
                // La réservation n'a pas été trouvée (peut-être déjà supprimée)
                completion(NSError(domain: "Reservation not found", code: 404, userInfo: nil))
            default:
                // Gérer d'autres codes de statut si nécessaire
                completion(NSError(domain: "Unexpected HTTP Status: \(httpResponse.statusCode)", code: httpResponse.statusCode, userInfo: nil))
            }
        }.resume()
    }
    
    
    
    func updateReservation(_ reservationId: String, updatedReservation: ReservationRequest) {
        // Define the API endpoint URL
        let apiUrlString = "http://192.168.155.177:9090/res/\(reservationId)"
        
        // Create the URL
        guard let url = URL(string: apiUrlString) else {
            //completion(false)
            return
        }
        
        // Create the request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        // Create the request body
        let requestBody: [String: Any] = [
            "DateDebut": dateFormatter.string(from: updatedReservation.DateDebut),
            "DateFin": dateFormatter.string(from: updatedReservation.DateFin),
            "HeureDebut": updatedReservation.HeureDebut,
            "HeureFin": updatedReservation.HeureFin,
            "Statut": updatedReservation.Statut.rawValue,
            "Total": 0.0
        ]
        
        do {
            // Convert the request body to JSON data
            let jsonData = try JSONSerialization.data(withJSONObject: requestBody)
            request.httpBody = jsonData
        } catch {
            //completion(false)
            return
        }
        
        // Perform the request
        URLSession.shared.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error updating reservation: \(error)")
               // completion(false)
                return
            }
            
            // Check for a successful HTTP response
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                // Reservation updated successfully
              //  completion(true)
            } else {
                // Reservation update failed
               // completion(false)
            }
        }.resume()
    }


  



    
    
}

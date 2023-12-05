import Foundation

class ReservationViewModel: ObservableObject {
    @Published var reservations: [Reservation]?

    func fetchReservations() {
        guard let url = URL(string: "http://172.20.10.5:9090/res") else {
            return
        }

        URLSession.shared.dataTask(with: url) { data, response, error in
            DispatchQueue.main.async {
                guard let data = data, error == nil else {
                    return
                }

                do {
                    let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]]
                    let reservations = jsonArray?.compactMap { Reservation(json: $0) }

                    self.reservations = reservations
//                    print("reservationsJSON------------------")
//                    print(jsonArray ?? "no json")
//                    print("reservations----------------------")
//                    print(reservations ?? "no res")
//                    print("self.reservations-----------------")
//                    print(self.reservations ?? "no self res")
                } catch {
                    self.reservations = nil
                }
            }
        }.resume()
    }
}

import Foundation

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoading: Bool = false
    

    
      @Published var errorMessage: String?
    
    private let flotteService = FlotteService.shared

   /* func fetchCars() {
        isLoading = true
        flotteService.getCars { result in
            DispatchQueue.main.async {
                self.isLoading = false
                switch result {
                case .success(let cars):
                    self.cars = cars
                case .failure(let error):
                    print("Error fetching cars: \(error.localizedDescription)")
                }
            }
        }
    }*/
    
    func fetchCars() async {
           do {
               self.cars = try await FlotteService.getCars()
           } catch {
               self.errorMessage = "Failed to fetch cars: \(error.localizedDescription)"
           }
       }
    
    func deleteCar(immatriculation: String) async {
            do {
                try await FlotteService.deleteCar(immatriculation: immatriculation)
                // Handle success, maybe refresh your list of cars
            } catch {
                // Handle the error, display an alert, etc.
                print("Error deleting car: \(error)")
            }
        }

    func createCar(car: CarRequest) {
        // Create a CarRequest object from the Car
        let carRequest = CarRequest(
            //id: nil,  // Assuming id is optional in CarRequest
            immatriculation: car.immatriculation,
            marque: car.marque,
            modele: car.modele,
            image: car.image,
            cylindree: car.cylindree,
            etatVoiture: car.etatVoiture,
            type: car.type,
            prixParJour: car.prixParJour
        )
        
        // Call the createCar function with the CarRequest object
        flotteService.createCar(car: carRequest) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let createdCar):
                    // Optionally, update the UI or perform any other actions
                    print("Car added successfully: \(createdCar)")
                case .failure(let error):
                    // Provide more context about the error
                    print("Error adding car: \(error.localizedDescription)")
                }
            }
        }
    }



//    func updateCar(immatriculation: String, car: Car) {
//        flotteService.updateCar(immatriculation: immatriculation, car: car) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success(let updatedCar):
//                    // Optionally, update the UI or perform any other actions
//                    print("Car updated successfully: \(updatedCar)")
//                case .failure(let error):
//                    print("Error updating car: \(error.localizedDescription)")
//                }
//            }
//        }
//    }

//    func deleteCar(immatriculation: String) {
//        flotteService.deleteCar(immatriculation: immatriculation) { result in
//            DispatchQueue.main.async {
//                switch result {
//                case .success:
//                    // Optionally, update the UI or perform any other actions
//                    print("Car deleted successfully")
//                case .failure(let error):
//                    print("Error deleting car: \(error.localizedDescription)")
//                }
//            }
//        }
//    }
}

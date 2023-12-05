import SwiftUI
import Combine

class CarViewModel: ObservableObject {
    @Published var cars: [Car] = []
    @Published var isLoading: Bool = false // Ajoutez cette ligne
    private var cancellables: Set<AnyCancellable> = []
    
    init() {
        fetchCars()
    }
    
    func fetchCars() {
        isLoading = true // Définir isLoading à true au début du chargement
        FlotteService.shared.fetchCars { [weak self] cars in
            DispatchQueue.main.async {
                self?.cars = cars ?? []
                self?.isLoading = false // Définir isLoading à false une fois le chargement terminé
            }
        }
    }
}

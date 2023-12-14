import Foundation

class EntretienViewModel: ObservableObject {
    @Published var historiqueEntretiens: [HistoriqueEntretiens] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    
    private let entretienService = EntretienService.shared
    
    func fetchEntretiens() {
        self.isLoading = true
        
        Task {
            do {
                // Utilisez le service pour obtenir les entretiens de manière asynchrone
                let historiqueEntretiens = try await self.entretienService.getEntretiens()
                
                // Mettez à jour la propriété observable avec les entretiens sur le thread principal
                DispatchQueue.main.async {
                    self.historiqueEntretiens = historiqueEntretiens
                    self.isLoading = false
                }
            } catch {
                // En cas d'erreur, mettez à jour le message d'erreur sur le thread principal
                DispatchQueue.main.async {
                    self.isLoading = false
                    self.errorMessage = "Failed to fetch entretiens: \(error.localizedDescription)"
                }
            }
        }
    }
    
}

import SwiftUI
import Combine

class UserViewModel: ObservableObject {
    @Published var isSignedIn = false
    @Published var isLoading = false
    @Published var error: Error?
    @Published var user: UserSign?
    @Published var token: String?
    
    private let userService: UserService
    private var cancellables = Set<AnyCancellable>()
    
    init(userService: UserService = UserService.shared) {
        self.userService = userService
    }
    
    func signIn(email: String, password: String) {
        isLoading = true
        
        userService.signIn(email: email, password: password) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success:
                self.isSignedIn = true
                self.error = nil
            case .failure(let error):
                self.isSignedIn = false
                self.error = error
            }
        }
    }
    
    func signUp(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        isLoading = true
        
        userService.signUp(user: user) { [weak self] result in
            guard let self = self else { return }
            
            self.isLoading = false
            
            switch result {
            case .success:
                self.isSignedIn = true
                self.error = nil
                completion(.success(()))
            case .failure(let error):
                self.isSignedIn = false
                self.error = error
                completion(.failure(error))
            }
        }
    }
    
    @Published var email: String = ""
        
        func forgotPassword() {
            UserService.shared.forgotPassword(email: email) { result in
                DispatchQueue.main.async {
                    switch result {
                    case .success:
                        // Reset OTP sent successfully
                        // Handle the success case, such as showing a success message to the user
                        print("Reset OTP sent successfully")
                    case .failure(let error):
                        // Failed to send reset OTP
                        // Show an error message or perform appropriate action
                        print("Failed to send reset OTP: \(error.localizedDescription)")
                    }
                }
            }
        }
    
        @Published var otpCode = ""
        @Published var isOTPValid = false
        
        func verifyOTP() {
            UserService.shared.verifyOTP(email: email, otpCode: otpCode) { [weak self] result in
                switch result {
                case .success(let isOTPValid):
                    DispatchQueue.main.async {
                        self?.isOTPValid = isOTPValid
                    }
                case .failure(let error):
                    DispatchQueue.main.async {
                        self?.error = error.localizedDescription as? any Error
                    }
                }
            }
        }
    
    func handleSignInResponse(userData: UserData?, token: String?, error: Error?) {
        if let userData = userData, let token = token {
            if let id = UUID(uuidString: userData.id) {
                let user = UserSign(id: id, email: userData.email)
                self.user = user
            }
            self.token = token
        }
        
        self.error = error
        self.isSignedIn = false
    }
}

struct UserSign: Codable {
    let id: UUID
    let email: String
}

struct UserData: Codable {
    let id: String
    let email: String
}

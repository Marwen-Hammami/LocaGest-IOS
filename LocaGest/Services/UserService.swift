import Foundation

class UserService {
    static let shared = UserService()
    private let baseURL = "http://172.18.26.10:9090"
    
    func signIn(email: String, password: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let signInURL = URL(string: "\(baseURL)/User/signing")!
        var request = URLRequest(url: signInURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let signInData = ["email": email, "password": password]
        request.httpBody = try? JSONSerialization.data(withJSONObject: signInData)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Sign-in successful
                completion(.success(()))
            } else {
                // Sign-in failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    func signUp(user: User, completion: @escaping (Result<Void, Error>) -> Void) {
        let signUpURL = URL(string: "\(baseURL)/User/signup")!
        var request = URLRequest(url: signUpURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        request.httpBody = try? encoder.encode(user)
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NetworkError.invalidResponse))
                return
            }
            
            if httpResponse.statusCode == 200 {
                // Signup successful
                completion(.success(()))
            } else {
                // Signup failed
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    func forgotPassword(email: String, completion: @escaping (Result<Void, Error>) -> Void) {
            let forgotPasswordURL = URL(string: "\(baseURL)/User/password")!
            var request = URLRequest(url: forgotPasswordURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let forgotPasswordData = ["email": email]
            request.httpBody = try? JSONSerialization.data(withJSONObject: forgotPasswordData)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    // Reset OTP sent successfully
                    completion(.success(()))
                } else {
                    // Failed to send reset OTP
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
        
    func verifyOTP(email: String, otpCode: String, completion: @escaping (Result<Bool, Error>) -> Void) {
            let verifyOTPURL = URL(string: "\(baseURL)/User/otp")!
            var request = URLRequest(url: verifyOTPURL)
            request.httpMethod = "POST"
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let otpData: [String: Any] = [
                "email": email,
                "otpCode": otpCode
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: otpData)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    completion(.failure(error))
                    return
                }
                
                guard let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.invalidResponse))
                    return
                }
                
                if httpResponse.statusCode == 200 {
                    if let data = data {
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let isOTPValid = json["isOTPValid"] as? Bool {
                            completion(.success(isOTPValid))
                        } else {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    } else {
                        completion(.failure(NetworkError.invalidResponse))
                    }
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
    }
    
    


enum NetworkError: Error {
    case invalidResponse
    case requestFailed(Int)
}

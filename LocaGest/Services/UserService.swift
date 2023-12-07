import Foundation

class UserService {
    static let shared = UserService()
    private let baseURL = "http://172.18.26.10:9090"

    
  
    
    
            
    private var userID: String? // Store the user ID after signing in
        
        func saveUserID(_ userID: String) {
            self.userID = userID
            UserDefaults.standard.setValue(userID, forKey: "UserID")
        }
        
    func signIn(email: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
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
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
                        if let userData = json?["userData"] as? [String: Any],
                           let token = json?["token"] as? String,
                           let userID = userData["id"] as? String {
                            // Save the token and user ID in UserDefaults
                            UserDefaults.standard.setValue(token, forKey: "AuthToken")
                            self.saveUserID(userID)
                            completion(.success(token))
                        } else {
                            completion(.failure(NetworkError.invalidResponse))
                        }
                    } catch {
                        completion(.failure(error))
                    }
                } else {
                    completion(.failure(NetworkError.noData))
                }
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
    func updatePassword(email: String, password: String, confirmPassword: String, completion: @escaping (Result<Void, Error>) -> Void) {
        let updatePasswordURL = URL(string: "\(baseURL)/User/newpass")!
        var request = URLRequest(url: updatePasswordURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let updatePasswordData: [String: Any] = [
            "email": email,
            "password": password,
            "confirmPassword": confirmPassword
        ]
        
        request.httpBody = try? JSONSerialization.data(withJSONObject: updatePasswordData)
        
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
                // Password updated successfully
                completion(.success(()))
            } else {
                // Failed to update password
                completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
            }
        }.resume()
    }
    
    func getUser(userID: String, completion: @escaping (Result<User, Error>) -> Void) {
            let getUserURL = URL(string: "\(baseURL)/User/get/\(userID)")!
            
            URLSession.shared.dataTask(with: getUserURL) { data, response, error in
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
                        do {
                            let decoder = JSONDecoder()
                            let user = try decoder.decode(User.self, from: data)
                            completion(.success(user))
                        } catch {
                            completion(.failure(error))
                        }
                    } else {
                        completion(.failure(NetworkError.noData))
                    }
                } else if httpResponse.statusCode == 404 {
                    completion(.failure(NetworkError.noData))
                } else {
                    completion(.failure(NetworkError.requestFailed(httpResponse.statusCode)))
                }
            }.resume()
        }
    
    
    
    func updateUserUsername(username: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/username/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "username": username
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UserServiceError.noData))
                return
            }
            
            do {
                let updatedUser = try JSONDecoder().decode(User.self, from: data)
                completion(.success(updatedUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func updateUserPhone(phoneNumber: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/phone/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "phoneNumber": phoneNumber
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UserServiceError.noData))
                return
            }
            
            do {
                let updatedUser = try JSONDecoder().decode(User.self, from: data)
                completion(.success(updatedUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    func updateUserEmail(email: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/email/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let parameters: [String: Any] = [
            "email": email
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: .prettyPrinted)
        } catch {
            completion(.failure(error))
            return
        }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UserServiceError.noData))
                return
            }
            
            do {
                let updatedUser = try JSONDecoder().decode(User.self, from: data)
                completion(.success(updatedUser))
            } catch {
                completion(.failure(error))
            }
        }.resume()
    }
    
  
    func deleteUser(userID: String, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let userID = UserDefaults.standard.string(forKey: "UserID") else {
            completion(.failure(NetworkError.userIDNotFound))
            return
        }
        
        guard let url = URL(string: "\(baseURL)/User/delete/\(userID)") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        var request = URLRequest(url: url)

        request.httpMethod = "DELETE"
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Process the response if needed
            
            completion(.success(()))
        }.resume()
    }
    
    
    
    }
    
    


enum NetworkError: Error {
    case userIDNotFound
    case invalidURL
    case invalidResponse
    case requestFailed(Int)
    case noData
}


enum UserServiceError: Error {
    case invalidURL
    case noData
}


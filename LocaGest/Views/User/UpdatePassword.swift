import SwiftUI

struct UpdatePasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @State private var message = ""
    @State private var showingAlert = false
    
    private let userViewModel = UserViewModel()
    private let email: String
    
    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            self.email = savedEmail
        } else {
            self.email = ""
        }
    }
    
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            VStack {
                Text("Update Password")
                    .font(.title)
                    .padding(.bottom, 50)
                
                Image(systemName: "lock.shield.fill")
                    .font(.system(size: 100))
                    .foregroundColor(.blue)
                    .padding()
                
                SecureField("New Password", text: $newPassword)
                    .font(.system(size: 16))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
                
                SecureField("Confirm Password", text: $confirmPassword)
                    .font(.system(size: 16))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
                
                Button(action: {
                    updatePassword()
                }) {
                    Text("Update Password")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .cornerRadius(8)
                }
                .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding()
            .alert(isPresented: $showingAlert) {
                Alert(title: Text("Password Update"), message: Text(message), dismissButton: .default(Text("OK")))
            }
        }
    }
    
    private func updatePassword() {
        guard newPassword == confirmPassword else {
            message = "New password and confirm password do not match."
            showingAlert = true
            return
        }
        
        userViewModel.updatePassword(email: email, password: newPassword, confirmPassword: confirmPassword)
        
        // Handle the success or failure of the password update
        // Display the appropriate message to the user
        // Example:
        message = "Password updated successfully."
        showingAlert = true
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()            .environmentObject(UserViewModel())

    }
}

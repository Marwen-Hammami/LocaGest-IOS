import SwiftUI

struct UpdateUserPasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    @EnvironmentObject private var userViewModel: UserViewModel

    
    var body: some View {
        VStack {
            Image("Share link-rafiki")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text("Update Password")
                .font(.largeTitle)
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
                // Perform password update logic here
                updatePassword()
            }) {
                Text("Update Password")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
            .padding()
            
            Text("Note: Your new password must be at least 8 characters long and should contain a combination of letters, numbers, and special characters.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .multilineTextAlignment(.center)
                .padding()
            
            Spacer()
        }
        .padding()
        .navigationTitle("Update Password")
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
    
    private func updatePassword() {
        // Validate the new password and confirm password fields
        if newPassword.isEmpty || confirmPassword.isEmpty {
            // Display an error or show an alert indicating that fields are required
            return
        }
        
        if newPassword != confirmPassword {
            // Display an error or show an alert indicating that passwords don't match
            return
        }
        
        guard let userId = UserDefaults.standard.string(forKey: "UserID") else {
            // Handle the case where userId is not available in UserDefaults
            return
        }
        
        userViewModel.updateUserEmail(password: newPassword)
        // Reset the fields after successful update
        newPassword = ""
        confirmPassword = ""
        
        // Display a success message or show an alert indicating the password was updated
    }
}
struct UpdateUserPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUserPasswordView()            

    }
}

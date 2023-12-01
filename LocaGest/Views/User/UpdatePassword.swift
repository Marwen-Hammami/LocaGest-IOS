import SwiftUI

struct UpdatePasswordView: View {
    @State private var newPassword = ""
    @State private var confirmPassword = ""
    
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
                
                Image(systemName: "lock.shield.fill") // Add a lock icon
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
                    // Perform password update logic here
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
        }
    }
    
    private func updatePassword() {
        // Perform password update logic here
        // Validate current password, new password, and confirm password
        // Display success or error message to the user
    }
}

struct UpdatePasswordView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePasswordView()
    }
}

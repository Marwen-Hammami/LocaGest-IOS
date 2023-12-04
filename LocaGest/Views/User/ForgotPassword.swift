import SwiftUI

struct ForgotPasswordEmailView: View {
    @State private var emailAddress = ""
    @State private var isOTPViewPresented = false
    @State private var isEmailSent = false
    @State private var errorMessage = ""
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Image("resetPassword")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 250, height: 250)
                
                Text("Forgot Password")
                    .font(.title)
                    .fontWeight(.bold)
                
                Text("Enter your email address to reset your password.")
                    .multilineTextAlignment(.center)
                
                TextField("Enter your email ", text: $emailAddress)
                    .font(.system(size: 16))
                    .padding()
                    .background(
                        RoundedRectangle(cornerRadius: 10)
                            .stroke(Color.gray, lineWidth: 1)
                    )
                    .padding(.horizontal, 30)
                
                Button(action: {
                    // Handle send email action
                    isEmailSent = true
                    sendEmail()
                    
                }) {
                    Text("Send Email")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .cornerRadius(10)
                }
                .padding(.horizontal, 30)
                .disabled(emailAddress.isEmpty) // Disable button if email address is empty
                
                Text("If you didn't request to reset your password, please ignore this email.")
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 30)
                
                Spacer()
            }
            .padding()
            .background(
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
            )
            .alert(isPresented: $isEmailSent) {
                if errorMessage.isEmpty {
                    return Alert(
                        title: Text("Email Sent"),
                        message: Text("An email with instructions to reset your password has been sent to \(emailAddress)"),
                        dismissButton: .default(Text("OK")) {
                            isOTPViewPresented = true // Set the flag to present the OTP view
                        }
                    )
                } else {
                    return Alert(
                        title: Text("Email Sending Failed"),
                        message: Text(errorMessage),
                        dismissButton: .default(Text("OK"))
                    )
                }
            }
            .sheet(isPresented: $isOTPViewPresented) {
                OTPView() // Present the OTP view
            }
        }
    }
    
    private func sendEmail() {
        // Call the UserService.forgotPassword() method with a completion closure
        UserService.shared.forgotPassword(email: emailAddress) { result in
            switch result {
            case .success:
                // Email sending succeeded
                errorMessage = ""
            case .failure(let error):
                // Email sending failed
                errorMessage = error.localizedDescription
            }
        }
    }
}

struct ForgotPasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordEmailView()
    }
}

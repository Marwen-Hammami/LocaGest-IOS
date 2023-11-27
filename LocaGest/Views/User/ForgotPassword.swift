import SwiftUI

struct ForgotPasswordEmailView: View {
    @State private var emailAddress = ""
    
    var body: some View {
        VStack(spacing: 20) {
            Image("logo")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 250, height: 250)
            
            Text("Forgot Password")
                .font(.title)
                .fontWeight(.bold)
            
            Text("Enter your email address to reset your password.")
                .multilineTextAlignment(.center)
            
            TextField("Email Address", text: $emailAddress)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding(.horizontal, 30)
            
            Button(action: {
                // Handle send email action
            }) {
                Text("Send Email")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Accent"))
                    .cornerRadius(10)
            }
            
            Text("If you didn't request to reset your password, please ignore this email.")
                .multilineTextAlignment(.center)
            
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
    }
}

struct ForgotPasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordEmailView()
    }
}

import SwiftUI

struct ForgotPasswordEmailView: View {
    @State private var emailAddress = ""
    @State private var isOTPViewPresented = false
    
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
                
                NavigationLink(
                    destination: OTPView(),
                    isActive: $isOTPViewPresented,
                    label: {
                        Text("Send Email")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .cornerRadius(10)
                    })
                    .padding(.horizontal, 30)
                    .onTapGesture {
                        // Handle send email action
                        isOTPViewPresented = true
                    }
                
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
        }
    }
}



struct ForgotPasswordEmailView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordEmailView()
    }
}


import SwiftUI

struct OTPView: View {
    @State private var otp: String = ""
    @State private var isUpdatePasswordViewPresented = false
    @State private var isOTPValid = false
    @State private var error: Error? = nil
    
    private let email: String
    
    init() {
        if let savedEmail = UserDefaults.standard.string(forKey: "userEmail") {
            self.email = savedEmail
        } else {
            self.email = ""
        }
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color("Main"), Color.white]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .edgesIgnoringSafeArea(.all)
                
                VStack {
                    Image("resetPassword")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .padding()
                    
                    Text("Enter OTP")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.white)
                        .padding()
                    
                    TextField("Enter your otp", text: $otp)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding()
                    
                    NavigationLink(destination: UpdatePasswordView(), isActive: $isUpdatePasswordViewPresented) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        verifyOTP()
                    }) {
                        Text("Verify OTP")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .cornerRadius(8)
                    }
                    .padding()
                    
                    if let error = error {
                        Text(error.localizedDescription)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func verifyOTP() {
        UserService.shared.verifyOTP(email: email, otpCode: otp) { result in
            switch result {
            case .success(let isOTPValid):
                DispatchQueue.main.async {
                    self.isOTPValid = isOTPValid
                    if isOTPValid {
                        self.isUpdatePasswordViewPresented = true
                    } else {
                        self.error = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid OTP"])
                    }
                }
            case .failure(let error):
                DispatchQueue.main.async {
                    self.error = error
                }
            }
        }
    }
}

struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

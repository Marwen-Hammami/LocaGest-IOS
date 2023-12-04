import SwiftUI

struct OTPView: View {
    @State private var otp: String = ""
    @State private var isUpdatePasswordViewPresented = false
    
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
                    
                    HStack(spacing: 10) {
                        ForEach(0..<6, id: \.self) { index in
                            OTPDigitView(otp: $otp, digit: otpDigit(at: index))
                        }
                    }
                    .padding()
                    
                    NavigationLink(destination: UpdatePasswordView(), isActive: $isUpdatePasswordViewPresented) {
                        EmptyView()
                    }
                    
                    Button(action: {
                        // Perform OTP verification logic
                        verifyOTP()
                        isUpdatePasswordViewPresented = true
                    }) {
                        Text("Verify OTP")
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .cornerRadius(8)
                    }
                    .padding()
                }
            }
        }
        .navigationBarBackButtonHidden()
    }
    
    private func otpDigit(at index: Int) -> String {
        let digits = Array(otp)
        if index < digits.count {
            return String(digits[index])
        } else {
            return ""
        }
    }
    
    private func verifyOTP() {
        // Perform OTP verification logic here
        // Validate the entered OTP
        // Display success or error message to the user
    }
}

struct OTPDigitView: View {
    @Binding var otp: String
    let digit: String
    
    var body: some View {
        TextField("", text: Binding(
            get: {
                otp
            },
            set: { newValue in
                if newValue.count <= 1 {
                    otp = newValue
                }
            }
        ))
        .font(.title)
        .frame(width: 40, height: 40)
        .background(Color.gray.opacity(0.2))
        .cornerRadius(8)
        .padding(4)
        .multilineTextAlignment(.center)
        .keyboardType(.numberPad)
        .textContentType(.oneTimeCode)
    }
}



struct OTPView_Previews: PreviewProvider {
    static var previews: some View {
        OTPView()
    }
}

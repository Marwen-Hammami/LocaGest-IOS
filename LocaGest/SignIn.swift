import SwiftUI

struct LoginView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    
    @State private var isLogin = true
    
    var body: some View {
        VStack {
            // Add image
            Image("aaa")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 200, height: 200)
                .padding(.bottom, 50)
            
            Text(isLogin ? "Login" : "Sign Up")
                .font(.largeTitle)
                .fontWeight(.bold)
                .padding(.bottom, 30)
            
            VStack(spacing: 20) {
                if !isLogin {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                }
                
                TextField("Email", text: $email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
                
                SecureField("Password", text: $password)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding(.horizontal, 30)
            }
            
            Button(action: {
                if isLogin {
                    // Perform login action with email and password
                } else {
                    // Perform sign-up action with username, email, and password
                }
            }) {
                Text(isLogin ? "Login" : "Sign Up")
                    .foregroundColor(.white)
                    .font(.headline)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .padding(.horizontal, 30)
            }
            
            Button(action: {
                isLogin.toggle()
            }) {
                Text(isLogin ? "Create an account" : "Already have an account?")
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }
            .padding(.top, 20)
            
            Button(action: {
                // Handle forgot password action
            }) {
                Text("Forgot Password?")
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }
            .padding(.top, 10)
            
            // Add social media buttons
            HStack(spacing: 20) {
                Button(action: {
                    // Handle Facebook login action
                }) {
                    Image("img_symbol")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                
                Button(action: {
                    // Handle Google login action
                }) {
                    Image("img_group4")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
                
                Button(action: {
                    // Handle Apple login action
                }) {
                    Image("img_vector")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 40, height: 40)
                }
            }
            .padding(.top, 30)
            
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

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

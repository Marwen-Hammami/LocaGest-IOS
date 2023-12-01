import SwiftUI

struct SignUpView: View {
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var agreedToTerms = false
    @State private var isShowingAlert = false
    
    var body: some View {
        ZStack {
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
            
            
            VStack(spacing: 30, content: {
                Image("aaa")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 200, height: 200)
                    .padding(.bottom, 30)
                Spacer()
                
            })
            VStack(spacing: 20) {
                Spacer()
                Spacer()
                Spacer()
                
                
                Text("Sign Up")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(.top, 30)
                
                VStack(spacing: 20) {
                    TextField("Username", text: $username)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                    
                    TextField("Email", text: $email)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                    
                    SecureField("Password", text: $password)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .padding(.horizontal, 30)
                }
                .padding(.top, 50)
                
                Button(action: {
                    // Perform sign-up action with username, email, and password
                    if agreedToTerms {
                        // Proceed with sign-up
                        isShowingAlert = true
                    } else {
                        // Display error message about agreeing to terms
                        isShowingAlert = true
                    }
                }) {
                    Text("Sign Up")
                        .foregroundColor(.white)
                        .font(.headline)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color("Accent"))
                        .cornerRadius(10)
                        .padding(.horizontal, 30)
                }
                .padding(.top, 30)
                
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
                
                VStack(spacing: 10) {
                    HStack {
                        Image(systemName: agreedToTerms ? "checkmark.square.fill" : "square")
                            .resizable()
                            .frame(width: 20, height: 20)
                            .foregroundColor(agreedToTerms ? .green : .black)
                            .onTapGesture {
                                agreedToTerms.toggle()
                            }
                        
                        Text("I agree to the Terms and Conditions")
                            .foregroundColor(.black)
                            .font(.footnote)
                            .onTapGesture {
                                agreedToTerms.toggle()
                            }
                    }
                    
                    Button(action: {
                        // Show terms and conditions
                    }) {
                        Text("View Terms and Conditions")
                            .foregroundColor(.black)
                            .font(.footnote)
                    }
                }
                .padding(.top, 20)
                
                Spacer()
            }
        }
        .onTapGesture {
            // Dismiss the keyboard when tapping outside the text fields
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        }
        .alert(isPresented: $isShowingAlert) {
            if agreedToTerms {
                return Alert(
                    title: Text("Sign Up Successful"),
                    message: Text("Thank you for signing up!"),
                    dismissButton: .default(Text("OK"))
                )
            } else {
                return Alert(
                    title: Text("Error"),
                    message: Text("Please agree to the Terms and Conditions."),
                    dismissButton: .default(Text("OK"))
                )
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
static var previews: some View {
SignUpView()
}
}

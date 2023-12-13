import SwiftUI
import FBSDKLoginKit


struct LoginView: View {
    @EnvironmentObject var vm: ViewModel
    @State private var username = ""
    @State private var email = ""
    @State private var password = ""
    @State private var phoneNumber = ""
    @State private var isLogin = true
    @State private var selectedImage: UIImage? = nil
    @State private var isShowingImagePicker = false
    @State private var isForgotPasswordViewPresented = false
    @State private var rememberMe = false // Add a state variable to track "Remember Me" checkbox
    @State private var captchaInput = ""
    @State private var captchaCode: String?
    @State private var shouldNavigateToFlotte = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        
        NavigationView {
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
                        Button(action: {
                                           isShowingImagePicker = true
                                       }) {
                                           Text("Select Image")
                                       }
                                       .padding()
                                       .background(
                                           RoundedRectangle(cornerRadius: 10)
                                               .stroke(Color.gray, lineWidth: 1)
                                       )
                                       .padding(.horizontal, 30)
                                       .sheet(isPresented: $isShowingImagePicker) {
                                           ImagePicker(image: $selectedImage)
                                       }
                        TextField("Username", text: $username)
                            .font(.system(size: 16))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal, 30)
                        TextField("PhoneNumber", text: $phoneNumber)
                            .font(.system(size: 16))
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .stroke(Color.gray, lineWidth: 1)
                            )
                            .padding(.horizontal, 30)
                        
                        
                       
                                           
                        
                       
                       
                                       
                                       // Additional code for handling image upload, if required
                        if let captchaCode = captchaCode {
                                                   Text("Captcha: \(captchaCode)")
                                                       .font(.system(size: 16))
                                               }
                                               
                                               TextField("Enter Captcha", text: $captchaInput)
                                                   .font(.system(size: 16))
                                                   .padding()
                                                   .background(
                                                       RoundedRectangle(cornerRadius: 10)
                                                           .stroke(Color.gray, lineWidth: 1)
                                                   )
                                                   .padding(.horizontal, 30)
                                   
                    }
                    
                    TextField("Email", text: $email)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                    
                    SecureField("Password", text: $password)
                        .font(.system(size: 16))
                        .padding()
                        .background(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.horizontal, 30)
                }
                
                Toggle(isOn: $rememberMe) {
                    Text("Remember Me")
                        .foregroundColor(.blue)
                        .font(.body)
                }
                .padding(.top, 10)
                           .padding(.horizontal, 0)
                           .toggleStyle(CheckboxToggleStyle()) // Apply custom checkbox style
                           .padding(.trailing, 155) // Add trailing padding to align to the right

                Button(action: {
                    if isLogin {
                        // Perform login action with email and password
                        UserService.shared.signIn(email: email, password: password) { result in
                            switch result {
                            case .success:
                                // Login successful
                                shouldNavigateToFlotte = true // Set the flag to navigate to FlotteMainView
                                if rememberMe {
                                                                    // Store the email and password in UserDefaults
                                                                    UserDefaults.standard.set(email, forKey: "RememberedEmail")
                                                                    UserDefaults.standard.set(password, forKey: "RememberedPassword")
                                                                } else {
                                                                    // Clear the stored email and password from UserDefaults
                                                                    UserDefaults.standard.removeObject(forKey: "RememberedEmail")
                                                                    UserDefaults.standard.removeObject(forKey: "RememberedPassword")
                                                                }
                                                           
                            case .failure(let error):
                                // Login failed
                                // Show an error message or perform appropriate action
                                print("Login failed: \(error.localizedDescription)")
                            }
                        }
                    } else {
                        
                        if captchaInput == captchaCode {
                            // Captcha verification successful
                            // Perform sign-up action with user details
                            let newUser = User(username: username, email: email, password: password, phoneNumber: phoneNumber)
                            UserService.shared.signUp(user: newUser) { result in
                                switch result {
                                case .success:
                                    // Signup successful
                                    shouldNavigateToFlotte = true
                                case .failure(let error):
                                    // Signup failed
                                    // Show an error message or perform appropriate action
                                    alertMessage = error.localizedDescription
                                    showAlert = true
                                }
                            }
                        } else {
                            // Captcha verification failed
                            // Show an error message or perform appropriate action
                            alertMessage = "Captcha verification failed"
                            showAlert = true
                        }
                    }
                    
                }) {
                    Text(isLogin ? "Login" : "Sign Up")
                            .foregroundColor(.white)
                            .font(.headline)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color("Accent"))
                            .cornerRadius(10)
                            .padding(.horizontal, 30)
                    }
                    .alert(isPresented: $showAlert) {
                        Alert(title: Text("Error"), message: Text(alertMessage), dismissButton: .default(Text("OK")))
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
                    isForgotPasswordViewPresented = true
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
                        LoginManager().logIn(permissions: ["public_profile", "email"], from: nil) { result, error in
                                                   if let error = error {
                                                       print("Facebook login failed: \(error.localizedDescription)")
                                                       return
                                                   }
                                                   
                                                   if let result = result {
                                                       if !result.isCancelled {
                                                           // Facebook login successful
                                                           // Access the user's Facebook data and perform the necessary actions
                                                           let accessToken = AccessToken.current
                                                           let userID = accessToken?.userID
                                                           print("Facebook login successful. User ID: \(userID ?? "")")
                                                           
                                                           // Navigate to the FlotteMainView
                                                           shouldNavigateToFlotte = true
                                                       } else {
                                                           print("Facebook login cancelled")
                                                       }
                                                   }
                                               }
                               
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
            .navigationTitle("")
            .sheet(isPresented: $isForgotPasswordViewPresented) {
                ForgotPasswordEmailView()
            }
            .background(
                NavigationLink(destination:
                                FlotteMainView()
                                    .environmentObject(vm)
                                    .navigationBarBackButtonHidden(true)
                                , isActive: $shouldNavigateToFlotte) {
                    EmptyView()
                }
            )
            
        }
        
        .navigationBarBackButtonHidden()
        .onAppear {
            // Generate a random captcha code on login view appear
            captchaCode = generateRandomCaptcha()
        }
    }
        
    init() {
        
        // Check if email and password are stored in UserDefaults
        if let rememberedEmail = UserDefaults.standard.string(forKey: "RememberedEmail"),
           let rememberedPassword = UserDefaults.standard.string(forKey: "RememberedPassword") {
            email = rememberedEmail
            password = rememberedPassword
            rememberMe = true
        }
    }	
    func generateRandomCaptcha() -> String {
        let chars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        var captcha = ""
        for _ in 0..<6 {
            let randomIndex = chars.index(chars.startIndex, offsetBy: Int.random(in: 0..<chars.count))
            captcha.append(chars[randomIndex])
        }
        return captcha
    }
    
}

struct ImagePicker: UIViewControllerRepresentable {
    @Binding var image: UIImage?
    @Environment(\.presentationMode) private var presentationMode
    
    func makeUIViewController(context: Context) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        let parent: ImagePicker
        
        init(_ parent: ImagePicker) {
            self.parent = parent
        }
        
        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
            if let uiImage = info[.originalImage] as? UIImage {
                parent.image = uiImage
            }
            parent.presentationMode.wrappedValue.dismiss()
        }
        
        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.presentationMode.wrappedValue.dismiss()
        }
    }
}
    

    
    struct LoginView_Previews: PreviewProvider {
        static var previews: some View {
            let viewModel = ViewModel(/* initialize your ViewModel with required parameters */)
            
            return LoginView()
                .environmentObject(viewModel)
        }
    }



import SwiftUI

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

    @State private var shouldNavigateToFlotte = false
    
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
                        // Perform sign-up action with user details
                        let newUser = User(username : username , email : email ,password: password, phoneNumber: phoneNumber) // Replace with the actual user details
                        UserService.shared.signUp(user: newUser) { result in
                            switch result {
                            case .success:
                                // Signup successful
                                shouldNavigateToFlotte = true // Set the flag to navigate to FlotteMainView
                            case .failure(let error):
                                // Signup failed
                                // Show an error message or perform appropriate action
                                print("Signup failed: \(error.localizedDescription)")
                            }
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



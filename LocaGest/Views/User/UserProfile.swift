import SwiftUI

struct UserProfile: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State private var showEmailAlert = false
    @State private var showUsernameAlert = false
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "English"
    @State private var isEditingProfile = false
    @StateObject private var router = Router() // Create an instance of the Router
    @StateObject private var userViewModel = UserViewModel()
    @AppStorage("userId") private var userId: String = ""
    @Environment(\.presentationMode) private var presentationMode
    var deleteUserCompletion: ((Result<Void, Error>) -> Void)?
    @State private var rotationAngle: Double = 0
    @State private var isEmailVerified = true // Add a boolean variable to track email verification status
    
    @EnvironmentObject var vm: ViewModel


    var body: some View {
        
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                Form {
                    Section(header: Text("Profile")) {
                        HStack {
                            VStack {
                                Image("client")
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 120, height: 120)
                                    .clipShape(Circle())
                                    .rotationEffect(Angle(degrees: rotationAngle))
                                    .padding(.bottom, 10)
                                    .onTapGesture {
                                        withAnimation {
                                            rotationAngle += 360
                                        }
                                    }
                                
                                Button(action: {
                                    isEditingProfile = true
                                }) {
                                    Text("Edit Profile")
                                        .foregroundColor(.blue)
                                        .font(.headline)
                                }
                                .sheet(isPresented: $isEditingProfile) {
                                    EditProfile()
                                }
                            }
                            
                            VStack(alignment: .leading) {
                                HStack {
                                    Image("img_symbol")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.blue)
                                    Text("Facebook")
                                }
                                
                                HStack {
                                    Image("img_group4")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.red)
                                    Text("Google")
                                }
                                HStack {
                                    Image("img_vector")
                                        .resizable()
                                        .frame(width: 20, height: 20)
                                        .foregroundColor(.red)
                                    Text("Apple")
                                }
                                
                            }
                            
                        }
                    }
                    
                    Section(header: Text("Language")) {
                        Picker("Language", selection: $selectedLanguage) {
                            Text("English").tag("English")
                            Text("French").tag("French")
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .onChange(of: selectedLanguage) { newValue in
                            if newValue == "French" {
                                // Perform actions to switch to French language
                            } else {
                                // Perform actions to switch to English language
                            }
                        }
                    }
                                        
                    Section(header: Text("Account")) {
                        NavigationLink(destination: UpdateUsernameView().environmentObject(userViewModel)) {
                            HStack {
                                Image(systemName: "person")
                                    .foregroundColor(.purple)
                                Text("Username")
                                Spacer()
                                Text(userViewModel.user?.username ?? "")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink(destination: UpdatePhoneNumberView().environmentObject(userViewModel)) {
                            HStack {
                                Image(systemName: "phone")
                                    .foregroundColor(.green)
                                Text("Phone Number")
                                Spacer()
                                Text(userViewModel.user?.phoneNumber ?? "")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink(destination: UpdateEmailView().environmentObject(userViewModel)) {
                            HStack {
                                Image(systemName: "envelope")
                                    .foregroundColor(.blue)
                                Text("Email")
                                Spacer()
                                Text(userViewModel.user?.email ?? "")
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        NavigationLink(destination: UpdateUserPasswordView().environmentObject(userViewModel)) {
                            HStack {
                                Image(systemName: "lock")
                                    .foregroundColor(.red)
                                Text("Password")
                                Spacer()
                                Text("********") // Display masked password or some other indicator
                                    .foregroundColor(.gray)
                            }
                        }
                    }
                    
                    
                                    

                    
                    
                    Section {
                        Toggle(isOn: $darkModeEnabled) {
                            Text("Dark Mode")
                        }
                    }
                    
                    Section {
                        Toggle(isOn: $notificationsEnabled) {
                            Text("Notifications")
                        }
                    }
                    Section {
                                            Button(action: {
                                                dismissToLoginView()
                                            }) {
                                                Text("Logout")
                                                    .foregroundColor(.red)
                                            }
                                        } 
                    Section {
                                            Button(action: {
                                                // Add account deletion logic here
                                               deleteUser()
                                            }) {
                                                Text("Delete Account")
                                                    .foregroundColor(.red)
                                            }
                                        }
                    
                    
                }
                
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button(action: {
                    router.navigateToRoot() // Navigate to the root of the navigation stack
                }) {
                    Text("")
                        .foregroundColor(.red)
                })
                
            }
            .navigationBarBackButtonHidden()
        }
        .onAppear {
            userViewModel.getUser() // Fetch the user data
        }
        


        .preferredColorScheme(darkModeEnabled ? .dark : .light)
        .alert(isPresented: $showEmailAlert) {
            Alert(title: Text("Email"), message: Text("You can edit your email here."), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showUsernameAlert) {
            Alert(title: Text("Username"), message: Text("You can edit your username here."), dismissButton: .default(Text("OK")))
        }
        .environmentObject(router) // Inject the router as an environment object
    }
    func deleteUser() {
        userViewModel.deleteUser(userID: userId) { result in
            self.deleteUserCompletion?(result)
            switch result {
                    case .success:
                        // User deleted successfully, remove all storage and dismiss to login view
                        self.clearUserStorage()
                        DispatchQueue.main.async {
                            self.dismissToLoginView()
                        }
                        
                    case .failure(let error):
                        // Handle the error appropriately
                        print("Failed to delete user: \(error)")
                    }
        }
        
    }
    private func clearUserStorage() {
        // Clear any user-specific data or storage
        // For example, you can reset UserDefaults or remove cached data
        UserDefaults.standard.removeObject(forKey: "userId")
        // Additional storage clearing code goes here
    }

    

    private func dismissToLoginView() {
        // Dismiss to the login view
        // You can use a suitable navigation technique or present the login view modally
        // For example, if using a navigation stack:
        presentationMode.wrappedValue.dismiss()
        
        // Present the login view modally
        let loginView = LoginView()
            .environmentObject(vm)
            //.navigationBarBackButtonHidden(true)// Replace "LoginView" with the actual name of your login view
        let hostingController = UIHostingController(rootView: loginView)
        hostingController.modalPresentationStyle = .fullScreen // Adjust the presentation style as needed
        UIApplication.shared.keyWindow?.rootViewController?.present(hostingController, animated: true, completion: nil)
    }
    
   
}



struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
        
    }
}

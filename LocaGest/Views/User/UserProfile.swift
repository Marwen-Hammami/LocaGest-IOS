import SwiftUI

struct UserProfile: View {
    @AppStorage("darkModeEnabled") private var darkModeEnabled = false
    @State private var showEmailAlert = false
    @State private var showUsernameAlert = false
    @State private var notificationsEnabled = true
    @State private var selectedLanguage = "English"
    @State private var isEditingProfile = false
    @StateObject private var router = Router() // Create an instance of the Router
    
    @State private var rotationAngle: Double = 0
    
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
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.blue)
                            Text("Email")
                            Spacer()
                            Text("MaherKaroui@gmail.com")
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            let emailAddress = "MaherKaroui@gmail.com"
                            guard let emailURL = URL(string: "mailto:\(emailAddress)") else {
                                return
                            }
                            UIApplication.shared.open(emailURL)
                        }
                    }
                    
                    Section {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.purple)
                            Text("Username")
                            Spacer()
                            Text("Maher")
                                .foregroundColor(.gray)
                        }
                        .onTapGesture {
                            showUsernameAlert = true
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
                    
                }
                .navigationBarTitle("Settings")
                .navigationBarItems(trailing: Button(action: {
                    router.navigateToRoot() // Navigate to the root of the navigation stack
                }) {
                    Text("Logout")
                        .foregroundColor(.red)
                })
            }
            .navigationBarBackButtonHidden()
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
}

struct UserProfile_Previews: PreviewProvider {
    static var previews: some View {
        UserProfile()
    }
}

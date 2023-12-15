import SwiftUI

struct UpdatePhoneNumberView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var newPhoneNumber = ""
    
    var body: some View {
        VStack {
            Image("Share link-rafiki")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text("Update Phone Number")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
            
            TextField("Phone Number", text: $newPhoneNumber)
                .font(.system(size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            Button(action: {
                updatePhoneNumber()
            }) {
                Text("Update Phone Number")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Accent"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Text("Enter a new phone number and click Update to update your profile.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear {
            newPhoneNumber = userViewModel.user?.phoneNumber ?? ""
        }
        .background(
            LinearGradient(
                gradient: Gradient(colors: [Color("Main"), Color.white]),
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )
            .edgesIgnoringSafeArea(.all)
        )
    }
    
    private func updatePhoneNumber() {
        guard let userId = UserDefaults.standard.string(forKey: "UserID") else {
            // Handle the case where userId is not available in UserDefaults
            return
        }
        
        userViewModel.updateUserPhone(phoneNumber: newPhoneNumber)
    }
}

struct UpdatePhoneNumberView_Previews: PreviewProvider {
    static var previews: some View {
        UpdatePhoneNumberView()
            .environmentObject(UserViewModel())
    }
}

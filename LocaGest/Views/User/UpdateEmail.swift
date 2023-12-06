import SwiftUI

struct UpdateEmailView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var newEmail = ""
    
    var body: some View {
        VStack {
            Image("Share link-rafiki")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text("Update Email")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
            
            TextField("Email", text: $newEmail)
                .font(.system(size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            Button(action: {
               updateEmail()
            }) {
                Text("Update Email")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Accent"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Text("Enter a new email address and click Update to update your profile.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear {
            newEmail = userViewModel.user?.email ?? ""
        }
    }
    
    private func updateEmail() {
        guard let userId = UserDefaults.standard.string(forKey: "UserID") else {
            // Handle the case where userId is not available in UserDefaults
            return
        }
        
        userViewModel.updateUserEmail(email: newEmail)
    }
}

struct UpdateEmailView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateEmailView()
            .environmentObject(UserViewModel())
    }
}

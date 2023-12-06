import SwiftUI

struct UpdateUsernameView: View {
    @EnvironmentObject private var userViewModel: UserViewModel
    @State private var newUsername = ""
    
    var body: some View {
        VStack {
            Image("Share link-rafiki")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text("Update Username")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .padding()
            
            TextField("Username", text: $newUsername)
                .font(.system(size: 16))
                .padding()
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(Color.gray, lineWidth: 1)
                )
                .padding(.horizontal, 30)
            
            Button(action: {
                updateUserUsername()
                
            }) {
                Text("Update Username")
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color("Accent"))
                    .cornerRadius(8)
            }
            .padding(.horizontal, 30)
            
            Spacer()
            
            Text("Enter a new username and click Save to update your profile.")
                .font(.subheadline)
                .foregroundColor(.gray)
                .padding()
        }
        .onAppear {
            newUsername = userViewModel.user?.username ?? ""
        }
    }
    
    private func updateUserUsername() {
        guard let userId = UserDefaults.standard.string(forKey: "UserID") else {
            // Handle the case where userId is not available in UserDefaults
            return
        }

        userViewModel.updateUserUsername(username: newUsername)
    }
}

struct UpdateUsernameView_Previews: PreviewProvider {
    static var previews: some View {
        UpdateUsernameView()
            .environmentObject(UserViewModel())
    }
}

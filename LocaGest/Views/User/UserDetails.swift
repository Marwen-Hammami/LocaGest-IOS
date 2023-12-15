//
//  UserDetails.swift
//  LocaGest
//
//  Created by Maher Karoui on 5/12/2023.
import SwiftUI

struct UserDetails: View {
    @StateObject private var userViewModel = UserViewModel()

    var body: some View {
        ZStack {
            // Background
            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.purple]), startPoint: .top, endPoint: .bottom)
                .edgesIgnoringSafeArea(.all)
            
            NavigationView {
                Form {
                    Section(header: Text("Profile")) {
                        VStack {
                            Image("client")
                                .resizable()
                                .aspectRatio(contentMode: .fill)
                                .frame(width: 120, height: 120)
                                .clipShape(Circle())
                            
                            Text(userViewModel.user?.username ?? "")
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(.top, 10)
                        }
                    }
                    
                    Section(header: Text("Account")) {
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.purple)
                            Text("Username")
                            Spacer()
                            Text(userViewModel.user?.username ?? "")
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: "phone")
                                .foregroundColor(.green)
                            Text("Phone Number")
                            Spacer()
                            Text(userViewModel.user?.phoneNumber ?? "")
                                .foregroundColor(.gray)
                        }
                        
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.blue)
                            Text("Email")
                            Spacer()
                            Text(userViewModel.user?.email ?? "")
                                .foregroundColor(.gray)
                        }
                    }
                }
                .navigationBarTitle("User Profile")
            }
            .onAppear {
                userViewModel.getUser() // Fetch the user data
            }
        }
    }
}
struct UserDetails_Previews: PreviewProvider {
    static var previews: some View {
        UserDetails()
    }
}

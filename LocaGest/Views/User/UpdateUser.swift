//
//  Edit Profile.swift
//  AgriConnect
//
//  Created by MoatazMhamdi on 23/11/2023.
//

import Foundation
import SwiftUI

struct EditProfile: View {
    
    @State private var email = ""
    @State private var password = ""
    @State private var username = ""
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var navigationLinkActive: Bool = false
    @State private var showingAlert = false
    @State private var confirmPassword = ""
    @State private var isPasswordVisible = false
    
  
    
    var body: some View {
        
        
        ZStack {
            
            
            Image("edit")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .edgesIgnoringSafeArea(.all)
                .opacity(0.2)
           
            Text("Edit Profile")
                .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                .position(x:380, y:23)
            
            VStack {
               
                Image("name")
                    .resizable()
                    .scaledToFit()
                    .offset(x:0,y:20)
                Text("Please enter your new informations")
                    .fontWeight(.medium)
                    .padding(10)
                
                VStack {
                    ZStack(alignment: .leading) {
                        if username.isEmpty {
                            Text("Username")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        HStack {
                            Image(systemName: "person")
                                .foregroundColor(.black)
                                .padding(.leading, 8)
                            TextField("", text: $username)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                    }
                    .frame(width: 343, height: 51)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(10)
                    
                    
                    ZStack(alignment: .leading) {
                        if email.isEmpty {
                            Text("Email")
                                .foregroundColor(.black)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        HStack {
                            Image(systemName: "envelope")
                                .foregroundColor(.black)
                                .padding(.leading, 8)
                            TextField("", text: $email)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                    }
                    .frame(width: 343, height: 51)
                    .background(Color.black.opacity(0.05))
                    .cornerRadius(12)
                    .padding(10)
                }
                ZStack(alignment: .leading) {
                    if firstName.isEmpty {
                        Text("+216")
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    HStack {
                        Image(systemName: "phone")
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        TextField("", text: $firstName)
                            .font(.title3)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                }
                .frame(width: 343, height: 51)
                .background(Color.black.opacity(0.05))
                .cornerRadius(12)
                .padding(10)
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("Password")
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        if isPasswordVisible {
                            TextField("", text: $password)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        } else {
                            SecureField("", text: $password)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .frame(width: 343, height: 51)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding(10)
                
                ZStack(alignment: .leading) {
                    if password.isEmpty {
                        Text("Password")
                            .foregroundColor(.black)
                            .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                    }
                    HStack {
                        Image(systemName: "lock")
                            .foregroundColor(.black)
                            .padding(.leading, 8)
                        if isPasswordVisible {
                            TextField("", text: $password)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        } else {
                            SecureField("", text: $password)
                                .font(.title3)
                                .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        }
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash.fill" : "eye.fill")
                                .foregroundColor(.black)
                        }
                        .padding(.trailing, 8)
                    }
                }
                .frame(width: 343, height: 51)
                .background(Color.black.opacity(0.05))
                .cornerRadius(10)
                .padding(10)
                
                
              
                Button(action: {
                    navigationLinkActive = true
                    
                  
                }) {
                    Text("Update")
                        .font(Font.custom("Inter", size: 20).weight(.bold))
                        .foregroundColor(.white)
                        .padding(EdgeInsets(top: 16, leading: 32, bottom: 16, trailing: 32))
                        .frame(width: 343, height: 51)
                        .background(Color("Main"))
                        .cornerRadius(12)
                }
                
                .alert(isPresented: $showingAlert) {
                    Alert(title: Text("Succed"), message: Text("Welcome our dear customer"), dismissButton: .default(Text("OK")))
                }
                
            }
                
            }
        
        }
    }


struct EditProfile_Previews: PreviewProvider {
    static var previews: some View {
        EditProfile()
    }
}

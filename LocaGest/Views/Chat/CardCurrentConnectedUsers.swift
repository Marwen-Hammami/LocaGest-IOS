//
//  CardCurrentConnectedUsers.swift
//  LocaGest
//
//  Created by Karim Hammami on 29/11/2023.
//

import SwiftUI

struct CardCurrentConnectedUsers: View {
    
    let users: [User] = [
        User(id: UUID(), username: "person3", email: "user1@example.com", password: "password1", firstName: "Samir", lastName: "person3", creditCardNumber: 1234567890123456, rate: Rate.good, specialization: "Developer", experience: 3, roles: Role.technician, isVerified: true, phoneNumber: "123-456-7890", resetToken: nil, resetTokenExpiration: nil, otpCode: nil, otpExpiration: nil),
            
        User(id: UUID(), username: "person2", email: "user2@example.com", password: "password2", firstName: "Amira", lastName: "Arbi", creditCardNumber: 9876543210987654, rate: Rate.good, specialization: "Designer", experience: 5, roles: Role.admin, isVerified: true, phoneNumber: "987-654-3210", resetToken: nil, resetTokenExpiration: nil, otpCode: nil, otpExpiration: nil),
            
            User(id: UUID(), username: "person", email: "user3@example.com", password: "password3", firstName: "Kawther", lastName: "Smith", creditCardNumber: nil, rate: Rate.good, specialization: "Marketing", experience: nil, roles: Role.admin, isVerified: false, phoneNumber: nil, resetToken: "resetToken123", resetTokenExpiration: Date(), otpCode: "otp123", otpExpiration: Date()),
        
        User(id: UUID(), username: "person2", email: "user1@example.com", password: "password1", firstName: "Layla", lastName: "Doe", creditCardNumber: 1234567890123456, rate: Rate.good, specialization: "Developer", experience: 3, roles: Role.technician, isVerified: true, phoneNumber: "123-456-7890", resetToken: nil, resetTokenExpiration: nil, otpCode: nil, otpExpiration: nil),
            
        User(id: UUID(), username: "person", email: "user2@example.com", password: "password2", firstName: "Latifa", lastName: "Doe", creditCardNumber: 9876543210987654, rate: Rate.good, specialization: "Designer", experience: 5, roles: Role.admin, isVerified: true, phoneNumber: "987-654-3210", resetToken: nil, resetTokenExpiration: nil, otpCode: nil, otpExpiration: nil)
            
        ]
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false){
            HStack(spacing: 32){
                ForEach(users){ user in
                    VStack{
                        ZStack(alignment: .bottomTrailing) {
                            Image(user.username!)
                                .resizable()
                                .frame(width: 60, height: 60)
                                .mask(Circle())
                            
                            ZStack{
                                Circle()
                                    .fill(.white)
                                    .frame(width: 18, height: 18)
                                
                                Circle()
                                    .fill(Color(.systemGreen))
                                    .frame(width: 12, height: 12)
                            }
                        }
                        Text(user.firstName!)
                            .font(.subheadline)
                            .foregroundColor(.gray)
                    }
                }
            }
            .padding()
        }
        .frame(height: 106)
    }
}

struct CardCurrentConnectedUsers_Previews: PreviewProvider {
    static var previews: some View {
        CardCurrentConnectedUsers()
    }
}

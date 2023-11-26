//
//  CardConversation.swift
//  LocaGest
//
//  Created by Karim Hammami on 26/11/2023.
//

import SwiftUI

struct CardConversation: View {
    var body: some View {
        VStack{
            HStack{
                Image("person")
                    .resizable()
                    .scaledToFill()
                    .mask(Circle())
                    .frame(width: 60, height: 60)
                Text("name")
                    .bold()
                    .font(.title2)
                    .opacity(0.7)
                    .padding()
                Spacer()
            }
            .padding(.horizontal)
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
                .foregroundColor(.black)
                .padding(.horizontal)
        }
    }
}

struct CardConversation_Previews: PreviewProvider {
    static var previews: some View {
        CardConversation()
    }
}

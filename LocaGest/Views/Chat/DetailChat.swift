//
//  DetailChat.swift
//  LocaGest
//
//  Created by El Mer on 30/11/2023.
//

import SwiftUI

struct DetailChat: View {
    let conversation: Conversation
    var body: some View {
        VStack{
            Text("Details Conversation")
                .font(.title)
                .fontWeight(.bold)
            
            Image(conversation.image)
                .resizable()
                .scaledToFill()
                .frame(width: 120, height: 120)
                .mask(Circle())
                .foregroundColor(Color(.systemGray4))
                .padding(.vertical)
            
            Text(conversation.members[1])
                .font(.title3)
                .fontWeight(.semibold)
            
            Text("Technicien")
                .font(.footnote)
                .foregroundColor(.gray)
                .padding(.bottom)
            
            Rectangle()
                .frame(height: 1)
                .opacity(0.2)
                .foregroundColor(.black)
                .padding(.horizontal)
            
            
            
            Spacer()
        }
    }
}

struct DetailChat_Previews: PreviewProvider {
    static var previews: some View {
        DetailChat(conversation: Conversation(
            members: ["id1","id2"],
            isGroup: false,
            name: "notGrp",
            image: "person"
        ))
    }
}

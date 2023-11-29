//
//  ConversationMessagesView.swift
//  LocaGest
//
//  Created by Karim Hammami on 28/11/2023.
//

import SwiftUI

struct ConversationMessagesView: View {
    let conversation: Conversation
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            .navigationBarTitle(conversation.isGroup ? conversation.name : conversation.members[1], displayMode: .inline)
            .navigationBarItems(
                leading: Image(conversation.image)
                    .resizable()
                    .scaledToFill()
                    .mask(Circle())
                    .frame(width: 30, height: 30),
                trailing: Image(systemName: "info.circle")
                    .foregroundColor(Color("Accent")))
    }
}

struct ConversationMessagesView_Previews: PreviewProvider {
    static var previews: some View {
        ConversationMessagesView(
            conversation: Conversation(
            members: ["id1","id2"],
            isGroup: false,
            name: "notGrp",
            image: "person"
        ))
    }
}

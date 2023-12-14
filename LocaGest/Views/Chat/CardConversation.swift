//
//  CardConversation.swift
//  LocaGest
//
//  Created by Karim Hammami on 26/11/2023.
//

import SwiftUI

struct CardConversation: View {
    let conversation: Conversation
    
    @State private var rotationAngle: Double = 0
    
    @State private var isConversationMessagesViewActive = false
    
    var body: some View {
        VStack{
            HStack{
                AsyncImage(url: URL(string: conversation.image)) { image in
                                    image.resizable()
                                        .scaledToFill()
                                        .mask(Circle())
                                        .frame(width: 60, height: 60)
                                } placeholder: {
                                    Image(systemName: "person.circle.fill")
                                    .resizable()
                                    .scaledToFill()
                                    .mask(Circle())
                                    .foregroundColor(.gray)
                                    .frame(width: 60, height: 60)
                                    .rotationEffect(Angle(degrees: rotationAngle))
                                    .onTapGesture {
                                        withAnimation {
                                            rotationAngle += 360
                                        }
                                    }
                                }

                Text(conversation.isGroup ? conversation.name : conversation.members[1])
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
        .onTapGesture {
                    isConversationMessagesViewActive = true
                }
                .background(
                    NavigationLink(
                        destination: ConversationMessagesView(conversation: conversation),
                        isActive: $isConversationMessagesViewActive,
                        label: { EmptyView() }
                    )
                )
    }
}

//struct CardConversation_Previews: PreviewProvider {
//    static var previews: some View {
//        CardConversation(conversation: Conversation(
//            members: ["id1","id2"],
//            isGroup: false,
//            name: "notGrp",
//            image: "person"
//        ))
//    }
//}

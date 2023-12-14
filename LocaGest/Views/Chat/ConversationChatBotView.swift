//
//  ConversationChatBotView.swift
//  LocaGest
//
//  Created by El Mer on 13/12/2023.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct ConversationChatBotView: View {
    @State private var showDialog: Bool = false
    
    @Environment(\.dismiss) var dismiss
    
    @State private var rotationAngle: Double = 0
    
    @StateObject private var messageViewModel = MessagesViewModel()
    let currentUser = "656e2bb566210cdf7c871d41"
    
    @State private var messageText = ""
    let conversation: Conversation
    @State private var messageToCopy = ""
    @State private var messageId = ""
    @State private var messageSender = ""
    var body: some View {
        VStack {
            ScrollView{
                VStack{
                    AsyncImage(url: URL(string: conversation.image)) { image in
                        image.resizable()
                            .scaledToFill()
                            .mask(Circle())
                            .frame(width: 120, height: 120)
                            .rotationEffect(Angle(degrees: rotationAngle))
                            .onTapGesture {
                                withAnimation {
                                    rotationAngle += 360
                                }
                            }
                    } placeholder: {
                        Image(systemName: "person.circle.fill")
                            .resizable()
                            .scaledToFill()
                            .mask(Circle())
                            .foregroundColor(.gray)
                            .frame(width: 120, height: 120)
                            .rotationEffect(Angle(degrees: rotationAngle))
                            .onTapGesture {
                                withAnimation {
                                    rotationAngle += 360
                                }
                            }
                    }
                    
                    Text(conversation.members[1])
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("ChatBot")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    //MESSAGES
                    if let messages = messageViewModel.messages {
                        ForEach(messages) { messa in
                            if(!messa.Archive) { //Ne pas afficher les messages archivées (liées au signalement)
                                CardMessage(message: messa, userImg: conversation.image)
                                    .onLongPressGesture {
                                        showDialog = true
                                        messageToCopy = messa.text
                                        messageId = messa._id
                                        messageSender = messa.sender
                                    }
                            }
                        }
                        .alert("Que voulais-vous effectuer ?", isPresented: $showDialog) {
                            Button("Copier", action: {
                                UIPasteboard.general.setValue(messageToCopy,
                                                              forPasteboardType: UTType.plainText.identifier)
                            })
                        }
                    } else {
                        ProgressView()
                            .onAppear {
                                messageViewModel.fetchMessages(forConvID: conversation._id)
                            }
                    }
                }
            }
//                .navigationBarTitle(conversation.isGroup ? conversation.name : conversation.members[1], displayMode: .inline)
//                .navigationBarItems(
//                    leading:
//                        AsyncImage(url: URL(string: conversation.image)) { image in
//                                            image.resizable()
//                                                .scaledToFill()
//                                                .mask(Circle())
//                                                .frame(width: 30, height: 30)
//                                                .rotationEffect(Angle(degrees: rotationAngle))
//                                                .onTapGesture {
//                                                    withAnimation {
//                                                        rotationAngle += 360
//                                                    }
//                                                }
//                                        } placeholder: {
//                                            Image(systemName: "person.circle.fill")
//                                            .resizable()
//                                            .scaledToFill()
//                                            .mask(Circle())
//                                            .foregroundColor(.gray)
//                                            .frame(width: 30, height: 30)
//                                            .rotationEffect(Angle(degrees: rotationAngle))
//                                            .onTapGesture {
//                                                withAnimation {
//                                                    rotationAngle += 360
//                                                }
//                                            }
//                                        },
//                    trailing: Image(systemName: "video.circle")
//                    .foregroundColor(Color("Accent"))
//                        .onTapGesture {
//                            //Demander une assistance humaine via video call
//                        }
//                                    )
            
            //Message Text Input
            ZStack{
                HStack{
                    HStack{
                        TextField("Message...", text: $messageText, axis: .vertical)
                            .padding(.vertical,12)
                            .padding(.leading,12)
                            .font(.subheadline)
                        
                        Button {

                                    if (messageText != "") {
                                        messageViewModel.addMessage(
                                            conversationId: conversation._id,
                                            sender: currentUser,
                                            text: messageText,
                                            file: []
                                        )
                                        messageText = ""
                                    }
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(Color("Accent"))
                        }
                        .padding(.trailing)
                    }
                    .background(Color(.systemGroupedBackground))
                    .clipShape(Capsule())
                }

            }
            .padding(.horizontal)
        }
    }
}

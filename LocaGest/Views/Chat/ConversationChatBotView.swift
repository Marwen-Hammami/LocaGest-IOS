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
    let userID = UserDefaults.standard.string(forKey: "UserID")
    
    @State private var otherUserName: String = ""
    @State private var otherUserPicture: String = ""
    
    @State private var messageText = ""
    let conversation: Conversation
    @State private var messageToCopy = ""
    @State private var messageId = ""
    @State private var messageSender = ""
    @State private var counter = 0
    @State private var timer: Timer?
    
    var body: some View {
        VStack {
            ScrollView {
                VStack {
                    AsyncImage(url: URL(string: otherUserPicture)) { image in
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
                    
                    Text(otherUserName)
                        .font(.title3)
                        .fontWeight(.semibold)
                    
                    Text("ChatBot")
                        .font(.footnote)
                        .foregroundColor(.gray)
                        .padding(.bottom)
                    
                    // MESSAGES
                    if let messages = messageViewModel.messages {
                        ForEach(messages) { messa in
                            if(!messa.Archive) {
                                CardMessage(message: messa, userImg: otherUserPicture)
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
            
            // Message Text Input
            ZStack {
                HStack {
                    HStack {
                        TextField("Message...", text: $messageText, axis: .vertical)
                            .padding(.vertical,12)
                            .padding(.leading,12)
                            .font(.subheadline)
                        
                        Button {
                            if messageText != "" {
                                // Send to chat
                                messageViewModel.sendMessageToChat(userMessage: messageText, convId: conversation._id) { result in
                                    switch result {
                                    case .success:
                                        // Handle success
                                        startFetchingMessagesTimer()
                                    case .failure(let error):
                                        // Handle failure
                                        print("Error sending message to chat bot: \(error)")
                                    }
                                }

                                // Add message to conv
                                messageViewModel.addMessage(
                                    conversationId: conversation._id,
                                    sender: userID!,
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
        .onAppear {
            // Fetch user information when the view appears
            if conversation.members.count > 0 {
                let otherUserID = conversation.members[1]
                UserService.shared.getUser(userID: otherUserID) { result in
                    switch result {
                    case .success(let user):
                        self.otherUserName = user.username!
                        self.otherUserPicture = user.image!
                    case .failure(let error):
                        print("Error fetching other user: \(error)")
                    }
                }
            }
        }
    }

    private func startFetchingMessagesTimer() {
        counter = 0
        timer?.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { [self] timer in
            if counter < 1 {
                messageViewModel.fetchMessages(forConvID: conversation._id)
                counter += 1
            } else {
                timer.invalidate()
            }
        }
    }
}

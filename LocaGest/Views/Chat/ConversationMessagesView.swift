//
//  ConversationMessagesView.swift
//  LocaGest
//
//  Created by Karim Hammami on 28/11/2023.
//

import SwiftUI
import PhotosUI
import UniformTypeIdentifiers

struct ConversationMessagesView: View {
    @State private var showDialog: Bool = false
    @State private var showConfirmDeleteDialog: Bool = false
    @State private var showRaisonSignalerDialog: Bool = false
    @State private var signalementResponseDiag: Bool = false
    @State private var signalementResponse: String = ""
    
    @Environment(\.dismiss) var dismiss
    
    @State private var rotationAngle: Double = 0
    
    @StateObject private var messageViewModel = MessagesViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID")
    
    @StateObject var viewModel = SelectedImageViewModel()
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
                    
                    Text("Technicien")
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
                            if (messageSender != userID) {
                                Button("Signaler", role: .destructive, action: {
                                    showRaisonSignalerDialog = true
                                })
                            }
                            if (messageSender == userID) {
                                Button("Supprimer", role: .destructive, action: {
                                    showConfirmDeleteDialog = true
                                })
                            }
                        }
                        .alert("Êtes vous sûres de vouloir supprimer ce message ?", isPresented: $showConfirmDeleteDialog) {
                            Button("Oui", role: .destructive, action: {
                                messageViewModel.deleteMessage(messageId: messageId) { result in
                                    switch result {
                                    case .success:
                                        // Handle successful deletion
                                        print("Message deleted successfully")

                                        // Optionally: Fetch the updated list of messages
                                        messageViewModel.fetchMessages(forConvID: conversation._id)

                                    case .failure(let error):
                                        // Handle deletion failure
                                        print("Error deleting message: \(error.localizedDescription)")
                                    }
                                }
                            })
                        }
                        .alert("Sélectionner la raison du signalement", isPresented: $showRaisonSignalerDialog) {
                            Button("Harcèlement", role: .destructive, action: {
                                messageViewModel.signalerMessage(messageId: messageId, signaleurId: userID!, raison: "Harcèlement", raisonAutre: "") { result in
                                    switch result {
                                    case .success(let response):
                                        // Handle the successful response
                                        messageViewModel.fetchMessages(forConvID: conversation._id)
                                        signalementResponse = response
                                        signalementResponseDiag = true
                                    case .failure(let error):
                                        // Handle the error
                                        print("Error: \(error.localizedDescription)")

                                    }
                                }
                            })
                        }
                        .alert(signalementResponse, isPresented: $signalementResponseDiag) {
                            Button("Ok", role: .destructive, action: {
                                signalementResponseDiag = false
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
                .navigationBarTitle(conversation.isGroup ? conversation.name : conversation.members[1], displayMode: .inline)
                .navigationBarItems(
                    leading:
                        AsyncImage(url: URL(string: conversation.image)) { image in
                                            image.resizable()
                                                .scaledToFill()
                                                .mask(Circle())
                                                .frame(width: 30, height: 30)
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
                                            .frame(width: 30, height: 30)
                                            .rotationEffect(Angle(degrees: rotationAngle))
                                            .onTapGesture {
                                                withAnimation {
                                                    rotationAngle += 360
                                                }
                                            }
                                        },
                    trailing: Image(systemName: "video.circle")
                    .foregroundColor(Color("Accent"))
                        .onTapGesture {
                            //call interface
                        }
                                    )
            
            //Message Text Input
            ZStack{
                HStack{
                    PhotosPicker(selection: $viewModel.selectedItem){
                        if let selectedImage = viewModel.selectedImage {
                            Image(uiImage: selectedImage) // Wrap UIImage with Image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 180, height: 180)
                                .clipShape(Rectangle())
                        } else {
                            Image(systemName: "photo.circle.fill")
                                .resizable()
                                .frame(width: 25, height: 25)
                                .foregroundColor(Color("Accent"))
                        }
                    }
                    HStack{
                        TextField("Message...", text: $messageText, axis: .vertical)
                            .padding(.vertical,12)
                            .padding(.leading,12)
                            .font(.subheadline)
                        
                        Button {
                            if let selectedImage = viewModel.selectedImage {
                                    // User has selected an image
                                    messageViewModel.addMessageWithImage(
                                        conversationId: conversation._id,
                                        sender: userID!,
                                        text: messageText,
                                        file: [selectedImage]
                                    )
                                    messageText = ""
                                } else {
                                    // No image selected
                                    if (messageText != "") {
                                        messageViewModel.addMessage(
                                            conversationId: conversation._id,
                                            sender: userID!,
                                            text: messageText,
                                            file: []
                                        )
                                        messageText = ""
                                    }
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

//struct ConversationMessagesView_Previews: PreviewProvider {
//    static var previews: some View {
//        ConversationMessagesView(
//            conversation: Conversation(
//            members: ["id1","id2"],
//            isGroup: false,
//            name: "notGrp",
//            image: "person"
//        ))
//    }
//}

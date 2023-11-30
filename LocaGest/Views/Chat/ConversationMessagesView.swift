//
//  ConversationMessagesView.swift
//  LocaGest
//
//  Created by Karim Hammami on 28/11/2023.
//

import SwiftUI
import PhotosUI

struct ConversationMessagesView: View {
    
    @StateObject var viewModel = SelectedImageViewModel()
    @State private var messageText = ""
    let conversation: Conversation
    var body: some View {
        VStack {
            ScrollView{
                VStack{
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
                    
                }
            }
                .navigationBarTitle(conversation.isGroup ? conversation.name : conversation.members[1], displayMode: .inline)
                .navigationBarItems(
                    leading: Image(conversation.image)
                        .resizable()
                        .scaledToFill()
                        .mask(Circle())
                        .frame(width: 30, height: 30),
                    trailing: Image(systemName: "info.circle")
                    .foregroundColor(Color("Accent")))
            
            //Message Text Input
            ZStack{
                HStack{
                    PhotosPicker(selection: $viewModel.selectedItem){
                        if let selectedImage = viewModel.selectedImage {
                            selectedImage
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
                            messageText = ""
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

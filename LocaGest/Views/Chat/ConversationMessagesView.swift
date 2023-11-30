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
    let conversation: Conversation
    var body: some View {
        VStack{
            Text("Choisir une image")
            
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
                        .frame(width: 80, height: 80)
                        .foregroundColor(Color(.systemGray4))
                }
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

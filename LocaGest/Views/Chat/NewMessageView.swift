//
//  NewMessageView.swift
//  LocaGest
//
//  Created by Karim Hammami on 29/11/2023.
//

import SwiftUI

struct NewMessageView: View {
    
    @StateObject private var viewModel = ConvsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID")
    
    @State private var searchText: String = ""
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack{
            HStack{
                Button("Annuler"){
                    dismiss()
                }
                
                Spacer()
                
                Text("Nouveau Message")
                    .font(.title)
                    .padding(.horizontal)
                
                Spacer()
                Spacer()
            }
            .padding(.horizontal)
            ScrollView{
                HStack {
                    TextField("À: Entrez un nom ou un groupe", text: $searchText)
                        .frame(height: 44)
                        .padding(.leading)
                    Button(action: {
                        searchText = ""
                    }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                        .frame(minWidth: 0, maxWidth: 20, alignment: .trailing)
                        .padding(.trailing)
                    }
                    .buttonStyle(PlainButtonStyle())
                }
                .background(Color(.systemGroupedBackground))
                
                Text("Contacts")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                if let conversations = viewModel.conversations {
                    ForEach(conversations.filter { item in
                        searchText.isEmpty ? true : item.members[1].localizedCaseInsensitiveContains(searchText)
                    })
                    { item in
                        CardConversation(conversation: item)
                    }
                } else {
                    // Show loading indicator or error message
                    ProgressView()
                        .onAppear {
                            viewModel.fetchConversations(forUserID: userID!)
                        }
                }
            }
        }
        
    }
}

struct NewMessageView_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageView()
    }
}

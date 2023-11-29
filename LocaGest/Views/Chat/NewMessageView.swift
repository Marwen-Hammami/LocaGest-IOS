//
//  NewMessageView.swift
//  LocaGest
//
//  Created by Karim Hammami on 29/11/2023.
//

import SwiftUI

struct NewMessageView: View {
    
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
                TextField("À: Entrez un nom ou un groupe", text: $searchText)
                    .frame(height: 44)
                    .padding(.leading)
                    .background(Color(.systemGroupedBackground))
                
                Text("Contacts")
                    .foregroundColor(.gray)
                    .font(.footnote)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
                ForEach(conversations){ item in
                    CardConversation(conversation: item)
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

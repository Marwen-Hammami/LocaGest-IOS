//
//  ChatMainView.swift
//  LocaGest
//
//  Created by Karim Hammami on 24/11/2023.
//

import SwiftUI

struct ChatMainView: View {
    @EnvironmentObject var vm: ViewModel
    @StateObject private var userViewModel = UserViewModel()
    @StateObject private var convsViewModel = ConvsViewModel()
    @State private var shouldRefreshView = false

    @State private var rotationAngle: Double = 0
    @State private var showNewMessageView = false
    var body: some View {
        ZStack{
            Color(.black)
                .ignoresSafeArea()
            SideBar()
                .opacity(vm.isopen ? 1 : 0)
            ZStack{
                Color(.white)
                VStack{
                    HStack{
                        SideBarButton()
                        
                        if(userViewModel.user?.roles == Role.client) {
                            Text("LocaGest ChatBot")
                                .font(.title)
                                .padding(.horizontal)
                            
                            Spacer()
                        } else {
                            Text("Discussions")
                                .font(.title)
                                .padding(.horizontal)
                            
                            Spacer()
                            ZStack{
                                Button(action: {
                                    //Add new Message
                                    showNewMessageView.toggle()
                                }, label: {
                                    Image(systemName:"plus.message")
                                        .foregroundColor(Color("Accent"))
                                })
                                Circle()
                                    .stroke(Color("Accent"), lineWidth: 2)
                                    .frame(height: 30)
                            }
                        }
                        
                        
                    }
                    .padding(.horizontal)

                        HomeView()
                    
                }
                .padding(.top, 50)
            }
            .mask(RoundedRectangle(cornerRadius: 30, style: .continuous))
            .rotation3DEffect(.degrees(30), axis: (x: 0, y: vm.isopen ? -1 : 0, z: 0))
            .offset(x: vm.isopen ? 250 : 0)
            .ignoresSafeArea()
        }
        .fullScreenCover(isPresented: $showNewMessageView, content: { NewMessageView()
        })
        .onAppear {
            vm.selecteditem = .chat
            userViewModel.getUser() // Fetch the user data
        }
    }
    @ViewBuilder
    func SideBarButton()-> some View{
        if vm.sideButton{
            Button(action: {
                withAnimation(.spring(response: 0.5, dampingFraction: 0.7)){
                    vm.isopen.toggle()
                    vm.sideButton.toggle()
                }
            }, label: {
                Image(systemName: "line.3.horizontal")
                    .font(.title)
                    .foregroundColor(.black)
            })
        }
    }
    
    @StateObject private var viewModel = ConvsViewModel()
    let userID = UserDefaults.standard.string(forKey: "UserID")
    
    @ViewBuilder
    func HomeView()-> some View{
        if(userViewModel.user?.roles == Role.client) {
            if let conversations = viewModel.conversations {
                if(conversations.count > 0) {
                    ConversationChatBotView(conversation: conversations[0])
                        .padding(.bottom, 15)
                }else {
                    //Create a new chatbot conversation
                    Text("Création de la conversation...")
                        .onAppear(){
                            if let userID = UserDefaults.standard.string(forKey: "UserID") {
                                convsViewModel.addConversation(members: [userID, "657b52068948af22d02152e1"], isGroup: false)
                                
                                shouldRefreshView = true
                            }
                        }
                        .background(
                            NavigationLink(destination:
                                            ChatMainView()
                                                .environmentObject(vm)
                                                .navigationBarBackButtonHidden(true)
                                            , isActive: $shouldRefreshView) {
                                EmptyView()
                            }
                        )
                }
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchConversations(forUserID: userID!)
                    }
            }
        }else {
            NavigationView {
                VStack {
                    if let conversations = viewModel.conversations {
                        List(conversations) { conversation in
                                CardConversation(conversation: conversation)
                        }
                    } else {
                        ProgressView()
                            .onAppear {
                                viewModel.fetchConversations(forUserID: userID!)
                            }
                    }
                }
                .navigationTitle("Conversations")
            }
        }
        }
    }

struct ChatMainView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMainView()
            .environmentObject(ViewModel())
    }
}

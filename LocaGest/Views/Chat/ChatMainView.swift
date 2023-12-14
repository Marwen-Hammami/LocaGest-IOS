//
//  ChatMainView.swift
//  LocaGest
//
//  Created by Karim Hammami on 24/11/2023.
//

import SwiftUI

struct ChatMainView: View {
    @EnvironmentObject var vm: ViewModel
    
//    let currentUserRole = "client"
    let currentUserRole = "technicien"
    
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
                        
                        if(currentUserRole == "client") {
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
    let currentUser = "656e2bb566210cdf7c871d41"
    
    @ViewBuilder
    func HomeView()-> some View{
        if(currentUserRole == "client") {
            if let conversations = viewModel.conversations {
                if(conversations.count > 0) {
                    ConversationChatBotView(conversation: conversations[0])
                        .padding(.bottom, 15)
                }else {
                    //Create a new chatbot conversation
                    //viewmodel method
                    //+display
                }
            } else {
                ProgressView()
                    .onAppear {
                        viewModel.fetchConversations(forUserID: currentUser)
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
                                viewModel.fetchConversations(forUserID: currentUser)
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

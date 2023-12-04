//
//  ChatMainView.swift
//  LocaGest
//
//  Created by Karim Hammami on 24/11/2023.
//

import SwiftUI

struct ChatMainView: View {
    @EnvironmentObject var vm: ViewModel
    
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
    
    @ViewBuilder
    func HomeView()-> some View{
        // Start - Here you can put your work ************************
//        Text("Marwen")
        VStack{
            ScrollView {
               // CardCurrentConnectedUsers()
                ForEach(conversations){ item in
                    CardConversation(conversation: item)
                }
            }
            
        }
        
        
        
        // End   - Here you can put your work ************************

        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct ChatMainView_Previews: PreviewProvider {
    static var previews: some View {
        ChatMainView()
            .environmentObject(ViewModel())
    }
}

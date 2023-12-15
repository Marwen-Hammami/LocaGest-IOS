import SwiftUI

struct CardMessage: View {
    let message: Message
    let userImg: String
    let userID = UserDefaults.standard.string(forKey: "UserID")
    var body: some View {
        HStack{
            if message.sender == userID {
                Spacer()
                
                if(message.Supprime){
                    Text("Vous avez retiré un message")
                        .font(.subheadline)
                        .padding(8)
                        .background(Color(.white))
                        .foregroundColor(.black)
                        .clipShape(Capsule())
                        .overlay(
                                Capsule()
                                    .stroke(Color.blue, lineWidth: 2) // Add a blue border with a lineWidth of 2
                            )
                } else {
                    VStack(alignment: .trailing) {
                        if (message.text != "") {
                            Text(message.text)
                                .font(.subheadline)
                                .padding(8)
                                .background(Color(.systemBlue))
                                .foregroundColor(.white)
                                .clipShape(Capsule())
                        }
                        switch message.file.count {
                        case 1:
                            AsyncImage(url: URL(string: message.file[0])) { image in
                                image
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 170, height: 170)
                                    .mask(Rectangle())
                                    .cornerRadius(10)
                                } placeholder: {
                                    ProgressView()
                                }
                        case 2:
                            HStack {
                                AsyncImage(url: URL(string: message.file[0])) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .mask(Rectangle())
                                        .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                                AsyncImage(url: URL(string: message.file[1])) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .mask(Rectangle())
                                        .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                            }
                        default:
                            Spacer()
                        }

                    }
                }
                
                
            } else {
                HStack(alignment: .top, spacing: 8) {
                    AsyncImage(url: URL(string: userImg)) { image in
                        image
                            .resizable()
                            .scaledToFill()
                            .frame(width: 20, height: 20)
                            .mask(Circle())
                            .foregroundColor(Color(.systemGray4))
                            .padding(.vertical)
                        } placeholder: {
                             ProgressView()
                        }
                    if(message.Supprime){
                        Text("A retiré un message")
                            .font(.subheadline)
                            .padding(8)
                            .background(Color(.white))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                            .overlay(
                                Capsule()
                                    .stroke(Color.gray, lineWidth: 2) // Add a blue border with a lineWidth of 2
                            )
                    } else {
                        VStack(alignment: .leading){
                            if (message.text != "") {
                                Text(message.text)
                                    .font(.subheadline)
                                    .padding(8)
                                    .background(Color(.systemGray5))
                                    .foregroundColor(.black)
                                    .clipShape(Capsule())
                            }
                            switch message.file.count {
                            case 1:
                                AsyncImage(url: URL(string: message.file[0])) { image in
                                    image
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 170, height: 170)
                                        .mask(Rectangle())
                                        .cornerRadius(10)
                                    } placeholder: {
                                        ProgressView()
                                    }
                            case 2:
                                HStack {
                                    AsyncImage(url: URL(string: message.file[0])) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 170, height: 170)
                                            .mask(Rectangle())
                                            .cornerRadius(10)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                    AsyncImage(url: URL(string: message.file[1])) { image in
                                        image
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 170, height: 170)
                                            .mask(Rectangle())
                                            .cornerRadius(10)
                                        } placeholder: {
                                            ProgressView()
                                        }
                                }
                            default:
                                Spacer()
                            }

                        }
                    }
                    
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

//struct CardMessage_Previews: PreviewProvider {
//    static var previews: some View {
//        CardMessage(message: Message(ConversationId: "1", sender: "id2", text: "Test Message", file: []))
//    }
//}

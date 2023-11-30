import SwiftUI

struct CardMessage: View {
    let message: Message
    var currentUserId = "id1"
    var body: some View {
        HStack{
            if message.sender == currentUserId {
                Spacer()
                
                VStack(alignment: .trailing) {
                    if (message.text != "") {
                        Text(message.text)
                            .font(.subheadline)
                            .padding(8)
                            .background(Color(.systemBlue))
                            .foregroundColor(.white)
                            .clipShape(Capsule())
                    }
                    if (message.file != []) {
                        Image(message.file[0])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 170, height: 170)
                            .mask(Rectangle())
                            .cornerRadius(10)
                            .foregroundColor(Color(.systemGray4))
                    }
                }
                
            } else {
                HStack(alignment: .center, spacing: 8) {
                    Image("person")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 20, height: 20)
                        .mask(Circle())
                        .foregroundColor(Color(.systemGray4))
                        .padding(.vertical)
                    
                    if (message.text != "") {
                        Text(message.text)
                            .font(.subheadline)
                            .padding(8)
                            .background(Color(.systemGray5))
                            .foregroundColor(.black)
                            .clipShape(Capsule())
                    }
                    if (message.file != []) {
                        Image(message.file[0])
                            .resizable()
                            .scaledToFill()
                            .frame(width: 170, height: 170)
                            .mask(Rectangle())
                            .cornerRadius(10)
                            .foregroundColor(Color(.systemGray4))
                    }
                    
                    Spacer()
                }
            }
        }
        .padding(.horizontal, 8)
    }
}

struct CardMessage_Previews: PreviewProvider {
    static var previews: some View {
        CardMessage(message: Message(ConversationId: "1", sender: "id2", text: "Test Message", file: []))
    }
}

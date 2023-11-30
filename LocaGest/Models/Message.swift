import Foundation

struct Message:Identifiable {
    var id = UUID()
    let ConversationId: String
    let sender: String
    let text: String
    let file: [String]
}

var messages = [
    Message(ConversationId: "1", sender: "id2", text: "Hello", file: []),
    Message(ConversationId: "1", sender: "id1", text: "hi", file: []),
    Message(ConversationId: "1", sender: "id2", text: "Comment tu vas", file: []),
    Message(ConversationId: "1", sender: "id1", text: "Bien et toi ?", file: []),
    Message(ConversationId: "1", sender: "id2", text: "", file: ["good"]),
    Message(ConversationId: "1", sender: "id1", text: "nice", file: ["good"]),
]

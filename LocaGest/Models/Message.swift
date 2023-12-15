import Foundation

struct Message:Identifiable {
    var id = UUID()
    var _id: String
    let conversationId: String
    let sender: String
    let text: String
    let file: [String]
    let Archive: Bool
    let Supprime: Bool
    
    init?(json: [String: Any]) {
        guard
            let file = json["file"] as? [String],
            let conversationId = json["conversationId"] as? String,
            let _id = json["_id"] as? String,
            let sender = json["sender"] as? String,
            let Archive = json ["Archive"] as? Bool,
            let Supprime = json ["Supprime"] as? Bool
        else {
            return nil
        }
        self.text = json["text"] as? String ?? ""
        self._id = _id
        self.file = file
        self.conversationId = conversationId
        self.sender = sender
        self.Archive = Archive
        self.Supprime = Supprime
        
    }
    
}

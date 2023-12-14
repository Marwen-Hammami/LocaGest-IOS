//
//  Conversation.swift
//  LocaGest
//
//  Created by Karim Hammami on 26/11/2023.
//

import Foundation

struct Conversation:Identifiable {
    var id = UUID()
    var _id: String
    let members: [String]
    let isGroup: Bool
    let name: String
    let image: String
    
    init?(json: [String: Any]) {
        guard
            let members = json["members"] as? [String],
            let isGroup = json["isGroup"] as? Bool,
            let name = json["name"] as? String,
            let _id = json["_id"] as? String,
            let image = json["image"] as? String
        else {
            return nil
        }
        
        self._id = _id
        self.members = members
        self.isGroup = isGroup
        self.name = name
        self.image = image
    }
}


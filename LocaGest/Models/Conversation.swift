//
//  Conversation.swift
//  LocaGest
//
//  Created by Karim Hammami on 26/11/2023.
//

import Foundation

struct Conversation {
    let members: [String]
    let isGroup: Bool
    let name: String
    let image: String
}

var Conversations = [
    Conversation(members: ["id1","id2"], isGroup: false, name: "notGrp", image: "path/to/grp/img"),
    Conversation(members: ["id1","id3"], isGroup: false, name: "notGrp", image: "path/to/grp/img"),
    Conversation(members: ["id1","id6","id3"], isGroup: true, name: "CCF4", image: "path/to/grp/img"),
    Conversation(members: ["id1","id4"], isGroup: false, name: "notGrp", image: "path/to/grp/img"),
    Conversation(members: ["id1","id5"], isGroup: false, name: "notGrp", image: "path/to/grp/img")
]

//
//  ChatModel.swift
//  swiftchat
//
//  Created by Benjamin. on 06/01/2024.
//

import Foundation

struct ChatModel: Codable, Identifiable, Hashable {
    let id:String
    let name:String
    
    var initials:String {
        return String(name.prefix(1))
    }
    
    static func sampleData() -> [ChatModel]{
        return [
            self.init(id: "1", name: "Gerald Kisses"),
            self.init(id: "2", name: "James McGray"),
            self.init(id: "3", name: "Daniel Lisan"),
            self.init(id: "4", name: "Kelvin Pauls")
        ]
    }
}

//
//  Message.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import Foundation

struct Message: Identifiable, Codable, Hashable {
    var id:String
    var text:String
    var received:Bool
    var timestamp:Date
    
    static func sampleData() -> [Message]{
        return [
            Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: false, timestamp: Date()),
            Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: false, timestamp: Date()),
            Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: true, timestamp: Date()),
            Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: true, timestamp: Date())
        ]
    }
}

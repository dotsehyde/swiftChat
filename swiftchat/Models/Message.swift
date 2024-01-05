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
}

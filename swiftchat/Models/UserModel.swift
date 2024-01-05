//
//  UserModel.swift
//  swiftchat
//
//  Created by Benjamin. on 05/01/2024.
//

import Foundation

struct UserModel: Codable, Identifiable, Hashable {
    var id: String
    var name:String
    var email:String
    
    static func empty() -> UserModel {
        return UserModel(id: "", name: "", email: "")
    }
}

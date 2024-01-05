//
//  MessageViewModel.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import Foundation

class MessageViewModel: ObservableObject {
    @Published var messages:[Message] = []
    @Published var lastMessageId:String = ""
    
    func getMessages(){
        
    }
    
    func sendMessage(){
        
    }
}

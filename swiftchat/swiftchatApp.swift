//
//  swiftchatApp.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI
import Firebase
import FirebaseAuth

@main
struct swiftchatApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    @StateObject var authViewModel = AuthViewModel()
    @StateObject  var messageController = MessageViewModel()
    var body: some Scene {
        WindowGroup {
       ContentView()
                .environmentObject(authViewModel)
                .environmentObject(messageController)
        }
        
    }
}

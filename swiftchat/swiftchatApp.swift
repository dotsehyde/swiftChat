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
    var body: some Scene {
        WindowGroup {
            if authViewModel.isLoggedin {
                ContentView(authViewModel: authViewModel)
            }else{
                AuthView(authViewModel: authViewModel)
            }
        }
    }
}

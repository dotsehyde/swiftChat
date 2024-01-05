//
//  ContentView.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI

struct ContentView: View {
    var messages: [Message] = [
        Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: false, timestamp: Date()),
        Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: false, timestamp: Date()),
        Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: true, timestamp: Date()),
        Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: true, timestamp: Date())
    ]
    @StateObject private var messageController = MessageViewModel()
    @ObservedObject var authViewModel: AuthViewModel
    var body: some View {
        VStack {
            VStack{
               ChatHeader(authViewModel: authViewModel)
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messages,id: \.self) { message in
                            ChatBubble(message: message )
                        }
                    }
                    .padding(.top,10)
                    .background(.white)
                .clipShape(RoundedCorner(radius: 10, corners: [.topLeft,.topRight]))
                .onChange(of: messageController.lastMessageId) { newValue in
                    proxy.scrollTo(newValue,anchor: .bottom)
                }
                }
                
                
            }
            .background(Color("Primary"))
            MessageField()
        }
        
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(authViewModel: AuthViewModel())
    }
}

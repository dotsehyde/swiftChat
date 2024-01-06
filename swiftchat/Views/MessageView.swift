//
//  MessageView.swift
//  swiftchat
//
//  Created by Benjamin. on 06/01/2024.
//

import SwiftUI

struct MessageView: View {
    var chat: ChatModel = ChatModel.sampleData()[0]
    @EnvironmentObject private var messageController: MessageViewModel
    var body: some View {
        VStack {
            VStack{
                ChatHeader(chat:chat)
                ScrollViewReader { proxy in
                    ScrollView {
                        ForEach(messageController.messages,id: \.self) { message in
                            ChatBubble(message: message )
                        }
                    }
                    
                    .onChange(of: messageController.lastMessageId) { newValue in
                        proxy.scrollTo(newValue,anchor: .bottom)
                    }
                }.padding(.top,10)
                    .background(.white)
                    .clipShape(RoundedCorner(radius: 20, corners: [.topLeft,.topRight]))
                    
                
                
            }
            .background(Color("Primary"))
            MessageField()
        }
        .onAppear{
            messageController.getMessages()
        }
        .navigationBarBackButtonHidden()
        
        
    }
}

struct MessageView_Previews: PreviewProvider {
    static var previews: some View {
        MessageView()
            .environmentObject(MessageViewModel())
    }
}

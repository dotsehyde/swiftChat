//
//  ChatView.swift
//  swiftchat
//
//  Created by Benjamin. on 06/01/2024.
//

import SwiftUI

struct ChatView: View {
    private var chats:[ChatModel] = ChatModel.sampleData()
    var body: some View {
        NavigationStack{
            List{
                ForEach(chats) { chat in
                    NavigationLink(value: chat) {
                        HStack(spacing: 12){
                            Circle()
                                .fill(Color("Primary"))
                                .frame(width: 50,height: 50)
                                .overlay(alignment: .center) {
                                    Text(chat.initials)
                                        .font(.headline)
                                        .fontWeight(.semibold)
                                        .foregroundStyle(.white)
                                }
                            
                            VStack(alignment: .leading, spacing: 5) {
                                Text(chat.name)
                                    .font(.subheadline)
                                    .fontWeight(.semibold)
                                Text("Tap to open")
                                    .font(.footnote)
                                    .foregroundStyle(.gray)
                            }
                            
                            
                        }
                    }
                    
                    
                }
            }
            .navigationDestination(for: ChatModel.self) { chat in
                MessageView(
                    chat: chat)
            }
            
            .navigationTitle("Chats")
            .toolbar {
                ToolbarItem {
                    Image(systemName: "plus")
                }
            }
        }
    }
}

struct ChatView_Previews: PreviewProvider {
    static var previews: some View {
        ChatView()
    }
}

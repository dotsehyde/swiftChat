//
//  ChatBubble.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI

struct ChatBubble: View {
    var message :Message
    @State private var showTime = false;
    var body: some View {
        VStack(alignment: message.received ? .leading : .trailing, content: {
            HStack {
                Text(message.text)
                    .padding()
                    .background(message.received ? Color("Gray") : Color("Primary"))
                    .cornerRadius(30)
            }
            .frame(maxWidth: 300, alignment: message.received ? .leading : .trailing)
            .onTapGesture {
                showTime.toggle()
            }
            if showTime{
                Text("\(message.timestamp.formatted(.dateTime.hour().minute()))")
                    .font(.caption2)
                    .foregroundColor(.gray)
                    .padding(message.received ? .leading : .trailing, 25)
            }
        })
        .frame(maxWidth: .infinity, alignment: message.received ? .leading : .trailing)
        .padding(message.received ? .leading : .trailing)
        .padding(.horizontal,10)
        .swipeActions(edge: .trailing) {
          Image(systemName: "trash")
            
        }
    }
}

struct ChatBubble_Previews: PreviewProvider {
    static var previews: some View {
        ChatBubble(
message: Message(id: "1234", text: "Hello World!, I'm coding in Swift and SwiftUI", received: false, timestamp: Date())
        ).previewLayout(.sizeThatFits)
    }
}

//
//  MessageFiel.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI

struct MessageField: View {
    @State private var message = ""
    @EnvironmentObject var messageViewModel: MessageViewModel
    var body: some View {
        HStack{
//            CustomTextField(placeholder: Text("Enter your message here..."), text: $message)
            TextField("Enter your message here...",text: $message)
            Button {
                //send message
                withAnimation {
                    messageViewModel.sendMessage(text: message)
                    message = ""
                }
               
            } label: {
                Image(systemName: "paperplane.fill")
                    .foregroundColor(.white)
                    .padding(10)
                    .background(Color("Primary"))
                    .cornerRadius(50)
            }

        }
        .padding(.horizontal)
        .padding(.vertical,10)
        .background(Color("Gray"))
        .clipShape(RoundedCorner(radius: 50))
        .padding(.horizontal)
    }
}

struct MessageField_Previews: PreviewProvider {
    static var previews: some View {
        MessageField().previewLayout(.sizeThatFits)
    }
}


struct CustomTextField: View {
    var placeholder: Text
    @Binding var text:String
    var editingChanged: (Bool) -> () = {_ in}
    var commit: () -> () = {}
    
    var body: some View {
        ZStack(alignment: .leading){
            if text.isEmpty{
                placeholder.opacity(0.5)
                
            }
            TextField("",text: $text, onEditingChanged: editingChanged, onCommit: commit )
        }
    }
    
}

//
//  ChatHeader.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import SwiftUI

struct ChatHeader: View {
    @EnvironmentObject var authViewModel:AuthViewModel
    @State private var showAlert = false
    var chat: ChatModel = ChatModel.sampleData()[0]
    @Environment(\.dismiss) private var dismiss
    var imageUrl = URL(string: "https://images.unsplash.com/photo-1580489944761-15a19d654956?q=80&w=3322&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D")
    
    var body: some View {
        VStack(alignment: .leading,spacing: 12) {
            Button{
               dismiss()
            }label: {
                Image(systemName: "chevron.left")
                    .imageScale(.large)
                    .foregroundStyle(.white)
            }
            .padding(.leading,10)
            HStack(spacing: 20) {
                
                
       
                  
                    Circle()
                        .fill(.white)
                        .frame(width: 60, height: 60)
                        .overlay {
                            Text(chat.initials)
                                .font(.title)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color("Primary"))
                        }
                
    //            AsyncImage(url: imageUrl) { img in
    //                img.resizable()
    //                    .aspectRatio(contentMode: .fill)
    //                    .frame(width: 50, height: 50)
    //                    .cornerRadius(50)
    //            } placeholder: {
    //                ProgressView()
    //            }
                VStack(alignment: .leading) {
                    Text(chat.name)
                        .font(.headline)
                        .bold()
                        
                    Text("Online")
                        .font(.caption)
                        .foregroundColor(.white)
                }
                .frame(maxWidth: .infinity,alignment: .leading)
                Image(systemName: "pip.exit")
                    .foregroundColor(.gray)
                    .padding(10)
                    .background(.white)
                    .cornerRadius(50)
                    .onTapGesture {
                        showAlert = true
                    }
            }
        }
        .padding()
//        .confirmationDialog("Logout", isPresented: $showAlert, actions: {
//            VStack{
//                Button("Yes") {
//                    authViewModel.logout()
//                }
//                Button("No") {
//                    withAnimation {
//                        showAlert.toggle()
//                    }
//
//                }
//            }
//        }, message: {
//            Text("Are you sure you want to log out?")
//        })
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Logout"),
                  message: Text("Are you sure you want to log out?"),
                  primaryButton: .cancel(Text("No")),
                  secondaryButton: .destructive(Text("Yes"), action: {
                authViewModel.logout()

            })
            )
        }
    }
}

struct ChatHeader_Previews: PreviewProvider {
    static var previews: some View {
        ChatHeader()
        
            .background(Color("Primary"))
    }
}

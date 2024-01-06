//
//  MessageViewModel.swift
//  swiftchat
//
//  Created by Benjamin. on 04/01/2024.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class MessageViewModel: ObservableObject {
    @Published var messages:[Message] = []
    @Published var lastMessageId:String = ""
    
    let db = Firestore.firestore()
    
    func getMessages(){
        self.messages.removeAll()
        print("Getting messages...")
        db.collection("messages").addSnapshotListener { snap, err in
            guard let docs = snap?.documents else{
                print("Error fetching document: \(err!.localizedDescription)")
                return
            }
            //Transform to Model
            self.messages = docs.compactMap { doc -> Message? in
                do {
                    return try doc.data(as: Message.self)
                }catch{
                    print("Error while transforming data: \(error)")
                    return nil
                }
                
            }
            self.messages.sort { $0.timestamp < $1.timestamp}
            if let id = self.messages.last?.id {
                self.lastMessageId = id
            }
           
        }
        
    }
    
    func delMessage (id:String) {
        db.collection("message").document(id).delete() { err in
            if err != nil {
                print("Couldn't delete message: \(err!.localizedDescription)")
            }
            
        }
    }
    
    func sendMessage(text:String){
        let today = Date()
        let id = String(Int.random(in: 100..<50000))
        db.collection("messages")
            .document(id)
            .setData([
                "id":id,
                "text":text,
                "timestamp":today,
                "received":false],
                     merge: true)
        
        print("Message sent")
    }
}
